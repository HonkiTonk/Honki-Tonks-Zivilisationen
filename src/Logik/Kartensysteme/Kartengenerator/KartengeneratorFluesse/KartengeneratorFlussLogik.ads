private with SystemDatentypenHTSEB;

private with KartenDatentypen;
private with KartenKonstanten;
private with KartenRecords;

package KartengeneratorFlussLogik is
   pragma Elaborate_Body;

   procedure GenerierungFlüsse;

private
   
   EbeneEnde : KartenDatentypen.EbeneVorhanden;
         
   LadezeitBasis : Float;
   
   Schleifenbereiche : KartenRecords.LandgrößenNaturalRecord;
   
   -- Später vom Nutzer einstellbar machen. äöü
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbenePlanet'Range) of SystemDatentypenHTSEB.NullBisHundert;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       KartenKonstanten.KernKonstante        => 30,
                                                                       KartenKonstanten.UnterflächeKonstante => 30,
                                                                       KartenKonstanten.OberflächeKonstante  => 30
                                                                      );

end KartengeneratorFlussLogik;
