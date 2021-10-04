pragma SPARK_Mode (On);

with GlobaleDatentypen;

with DatenbankRecords;

package RasseMenschen is

   RasseMenschenListe : constant DatenbankRecords.RassenListeRecord :=
     (
      Aggressivität       => 0,
      Expansion           => 20,
      Wissenschaft        => 0,
      Produktion          => 0,
      Wirtschaft          => 0,
      Bewirtschaftung     => 0,
      GültigeStaatsformen => (SonstigeDatentypen.Anarchie,
                               GlobaleDatentypen.Demokratie,
                               SonstigeDatentypen.Anarchie,
                               SonstigeDatentypen.Anarchie,
                               SonstigeDatentypen.Anarchie)
     );

end RasseMenschen;
