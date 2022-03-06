# Construct the URI from the .env
DB_HOST='ec2-44-192-245-97.compute-1.amazonaws.com'
DB_NAME='d8eldhoc5aracd'
DB_USER='tgikaceqjtlkhg'
DB_PORT='5432'
DB_PASSWORD='a5127064af53a8ef0434717731585ea1d98f350c51a6684aa1cec488455c377a'

while IFS= read -r line
do
  if [[ $line == DB_HOST* ]]
  then
    DB_HOST=$(cut -d "=" -f2- <<< $line | tr -d \')
  elif [[ $line == DB_NAME* ]]
  then
    DB_NAME=$(cut -d "=" -f2- <<< $line | tr -d \' )
  elif [[ $line == DB_USER* ]]
  then
    DB_USER=$(cut -d "=" -f2- <<< $line | tr -d \' )
  elif [[ $line == DB_PORT* ]]
  then
    DB_PORT=$(cut -d "=" -f2- <<< $line | tr -d \')
  elif [[ $line == DB_PASSWORD* ]]
  then
    DB_PASSWORD=$(cut -d "=" -f2- <<< $line | tr -d \')
  fi
done < ".env"

URI="postgres://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME"

# Run the scripts to insert data.
psql ${URI} -f sql/AppStoreClean.sql
psql ${URI} -f sql/AppStoreSchema.sql
psql ${URI} -f sql/AppStoreCustomers.sql
psql ${URI} -f sql/AppStoreGames.sql
psql ${URI} -f sql/AppStoreDownloads.sql
