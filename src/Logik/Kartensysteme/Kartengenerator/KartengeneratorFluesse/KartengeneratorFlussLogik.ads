private with KartenDatentypen;
private with SystemDatentypen;

private with AllgemeineBerechnungen;

package KartengeneratorFlussLogik is
   pragma Elaborate_Body;

   procedure GenerierungFlüsse;

private
   use type KartenDatentypen.Ebene;
         
   Kartenzeitwert : KartenDatentypen.KartenfeldPositiv;
   
   -- Später vom Nutzer einstellbar machen. äöü
   type WahrscheinlichkeitFlussArray is array (KartenDatentypen.EbenePlanet'Range) of SystemDatentypen.NullBisHundert;
   WahrscheinlichkeitFluss : constant WahrscheinlichkeitFlussArray := (
                                                                       -2 => 30,
                                                                       -1 => 30,
                                                                       0  => 30
                                                                      );
   
   
   
   function Basiszeitwert is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => KartenDatentypen.KartenfeldPositiv);

end KartengeneratorFlussLogik;
