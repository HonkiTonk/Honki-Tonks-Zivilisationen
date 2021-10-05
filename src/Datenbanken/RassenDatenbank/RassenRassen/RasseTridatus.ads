pragma SPARK_Mode (On);

with SonstigeDatentypen;

with DatenbankRecords;

package RasseTridatus is

   RasseTridatusListe : constant DatenbankRecords.RassenListeRecord :=
     (
      Aggressivität       => 0,
      Expansion           => 20,
      Wissenschaft        => 0,
      Produktion          => 0,
      Wirtschaft          => 0,
      Bewirtschaftung     => 0,
      GültigeStaatsformen => (SonstigeDatentypen.Anarchie,
                               SonstigeDatentypen.Demokratie,
                               SonstigeDatentypen.Anarchie,
                               SonstigeDatentypen.Anarchie,
                               SonstigeDatentypen.Anarchie)
     );

end RasseTridatus;
