CREATE OR REPLACE FUNCTION public.check_suspicious_transaction()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF NEW.transaction_amount > 500
       OR NEW.transaction_status = 'Flagged'
       OR NEW.transaction_status = 'Declined'
    THEN
        INSERT INTO fraud_alert
        (
            transaction_id,
            alert_reason,
            alert_date,
            alert_status
        )
        VALUES
        (
            NEW.transaction_id,
            'Suspicious transaction detected',
            NOW(),
            'Open'
        );
    END IF;

    RETURN NEW;
END;
$function$
;


CREATE OR REPLACE FUNCTION public.create_fraud_report(p_customer_id integer, p_transaction_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO fraud_report
    (
        customer_id,
        transaction_id,
        report_date,
        resolution_status
    )
    VALUES
    (
        p_customer_id,
        p_transaction_id,
        NOW(),
        'Pending'
    );

    UPDATE "transaction"
    SET transaction_status = 'Flagged'
    WHERE transaction_id = p_transaction_id;
END;
$function$
;


CREATE OR REPLACE FUNCTION public.create_rapid_transaction_fraud_alert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM public."transaction" t
        WHERE t.card_id = NEW.card_id
          AND t.transaction_id <> NEW.transaction_id
          AND t.transaction_date BETWEEN NEW.transaction_date - INTERVAL '10 minutes'
                                     AND NEW.transaction_date + INTERVAL '10 minutes'
    ) THEN
        INSERT INTO public.fraud_alert (
            transaction_id,
            alert_reason,
            alert_date,
            alert_status
        )
        VALUES (
            NEW.transaction_id,
            'Multiple transactions on the same card within 10 minutes',
            NOW(),
            'Open'
        );

        UPDATE public."transaction"
        SET transaction_status = 'Flagged'
        WHERE transaction_id = NEW.transaction_id;
    END IF;

    RETURN NEW;
END;
$function$
;


CREATE OR REPLACE FUNCTION public.flag_transaction_for_bad_device()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_device_status VARCHAR(20);
BEGIN
    SELECT device_status
    INTO v_device_status
    FROM device
    WHERE device_id = NEW.device_id;

    IF LOWER(v_device_status) IN ('blocked', 'inactive') THEN

        UPDATE "transaction"
        SET transaction_status = 'Flagged'
        WHERE transaction_id = NEW.transaction_id;

        INSERT INTO fraud_alert
        (
            transaction_id,
            alert_reason,
            alert_date,
            alert_status
        )
        VALUES
        (
            NEW.transaction_id,
            'Transaction made from blocked or inactive device',
            NOW(),
            'Open'
        );

    END IF;

    RETURN NEW;
END;
$function$
;
