private with SystemDatentypenHTSEB;

private with KommazahltestsHTSEB;

private with KartenDatentypen;
private with KartenKonstanten;

package KartengeneratorFlussLogik is
   pragma Elaborate_Body;

   procedure GenerierungFlüsse;

private
         
   LadezeitBasis : Float;
   Ladezeit : Float;
   
   -- Später vom Nutzer einstellbar machen. äöü
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbenePlanet'Range) of SystemDatentypenHTSEB.NullBisHundert;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       KartenKonstanten.PlaneteninneresKonstante => 30,
                                                                       KartenKonstanten.UnterflächeKonstante     => 30,
                                                                       KartenKonstanten.OberflächeKonstante      => 30
                                                                      );
   
   
   
   function LadezeitTesten is new KommazahltestsHTSEB.StrichrechnungNatural (Kommazahl => SystemDatentypenHTSEB.LadezeitBasis);

end KartengeneratorFlussLogik;
