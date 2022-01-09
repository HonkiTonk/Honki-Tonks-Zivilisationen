pragma SPARK_Mode (On);

with SystemDatentypen;

with DatenbankRecords;

package RasseSenelari is

   RasseSenelariListe : constant DatenbankRecords.RassenListeRecord :=
     (
      Aggressivität       => 0,
      Expansion           => 20,
      Wissenschaft        => 0,
      Produktion          => 0,
      Wirtschaft          => 0,
      Bewirtschaftung     => 0,
      GültigeStaatsformen => (SystemDatentypen.Anarchie,
                               SystemDatentypen.Demokratie,
                               SystemDatentypen.Anarchie,
                               SystemDatentypen.Anarchie,
                               SystemDatentypen.Anarchie)
     );

end RasseSenelari;
