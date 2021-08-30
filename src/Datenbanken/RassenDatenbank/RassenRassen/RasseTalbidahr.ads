pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package RasseTalbidahr is

   RasseTalbidahrListe : constant DatenbankRecords.RassenListeRecord :=
     (
      Aggressivität       => 0,
      Expansion           => 20,
      Wissenschaft        => 0,
      Produktion          => 0,
      Wirtschaft          => 0,
      Bewirtschaftung     => 0,
      GültigeStaatsformen => (GlobaleDatentypen.Anarchie,
                               GlobaleDatentypen.Demokratie,
                               GlobaleDatentypen.Anarchie,
                               GlobaleDatentypen.Anarchie,
                               GlobaleDatentypen.Anarchie)
     );

end RasseTalbidahr;
