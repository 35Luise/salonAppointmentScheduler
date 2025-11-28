#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

DISPLAY_SERVICES() {
  if [[ $1 ]]
  then
    echo "$1"
    echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim"
    # Ask service id
    read SERVICE_ID_SELECTED
    echo ""
    case $SERVICE_ID_SELECTED in
      1) LOGIC ;;
      2) LOGIC ;;
      3) LOGIC ;;
      4) LOGIC ;;
      5) LOGIC ;;
      *) DISPLAY_SERVICES "I could not find that service. What would you like today?" ;;
    esac
  else
    echo -e "Welcome to My Salon, how can I help you?\n"
    echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim"
    # Ask service id
    read SERVICE_ID_SELECTED
    echo ""
    case $SERVICE_ID_SELECTED in
      1) LOGIC ;;
      2) LOGIC ;;
      3) LOGIC ;;
      4) LOGIC ;;
      5) LOGIC ;;
      *) DISPLAY_SERVICES "I could not find that service. What would you like today?" ;;
    esac
  fi
}
LOGIC() {
  # Ask customer phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_ID ]]
then
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # Insert customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
fi
}
DISPLAY_SERVICES
