CREATE TRIGGER rapid_transaction_fraud_alert_trigger AFTER INSERT ON transaction FOR EACH ROW EXECUTE FUNCTION create_rapid_transaction_fraud_alert();


CREATE TRIGGER trg_check_suspicious_transaction AFTER INSERT ON transaction FOR EACH ROW EXECUTE FUNCTION check_suspicious_transaction();


CREATE TRIGGER trg_flag_transaction_for_bad_device AFTER INSERT ON transaction FOR EACH ROW EXECUTE FUNCTION flag_transaction_for_bad_device();


