USE f1_db
SELECT 
  --results.resultId, 
  results.number AS car_number, 
    RTRIM(
    LTRIM(
      CONCAT(
        COALESCE(drivers.forename + ' ', ''), 
        COALESCE(drivers.surname, '')
      )
    )
  ) AS driver_name, 
  drivers.nationality AS driver_nationality, 
  CAST(drivers.dob as date) AS driver_dob, 
  results.grid AS start_pos, 
  CASE WHEN results.position = '\N' THEN 'DNF' ELSE results.position END AS finish_pos, 
  results.points, 
  results.laps AS laps_done, 
  CASE WHEN results.fastestLapTime = '\N' THEN 'DNF' ELSE results.fastestLapTime END AS fastest_lap,
  status.status AS result_status, 
  races.round AS season_round, 
  CAST(races.date as date) AS race_date, 
  races.year AS race_year, 
  races.name AS race_name, 
  circuits.name AS track_name, 
  circuits.location AS race_location, 
  circuits.country AS race_country, 
  constructors.name AS constructor 
FROM 
  results 
  LEFT JOIN.status ON status.statusId = results.statusId 
  LEFT JOIN races ON races.raceId = results.raceId 
  LEFT JOIN circuits ON circuits.circuitId = races.circuitId 
  LEFT JOIN drivers ON drivers.driverId = results.driverId 
  LEFT JOIN constructors ON constructors.constructorId = results.constructorId 
WHERE
	results.position = '1'