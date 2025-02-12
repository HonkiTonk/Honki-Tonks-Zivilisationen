private with AllgemeineBerechnungenHTSEB;

private with KartenDatentypen;
private with SystemDatentypen;
private with KartenKonstanten;

package KartengeneratorFlussLogik is
   pragma Elaborate_Body;

   procedure GenerierungFlüsse;

private
         
   Kartenzeitwert : KartenDatentypen.SenkrechtePositiv;
   
   -- Später vom Nutzer einstellbar machen. äöü
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbenePlanet'Range) of SystemDatentypen.NullBisHundert;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       KartenKonstanten.PlaneteninneresKonstante => 30,
                                                                       KartenKonstanten.UnterflächeKonstante     => 30,
                                                                       KartenKonstanten.OberflächeKonstante      => 30
                                                                      );
   
   
   
   function Basiszeitwert is new AllgemeineBerechnungenHTSEB.Basiszeitwert (GanzeZahl => KartenDatentypen.SenkrechtePositiv);

end KartengeneratorFlussLogik;
