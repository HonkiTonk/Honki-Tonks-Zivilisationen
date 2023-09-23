with SpeziesDatentypen;

private with EinheitenDatentypen;
private with StadtDatentypen;

with LeseSpeziesbelegung;

private with AllgemeineBerechnungen;

package KILogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure KI
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   Städtezeitwert : StadtDatentypen.StädtebereichVorhanden;

   Einheitenzeitwert : EinheitenDatentypen.EinheitenbereichVorhanden;

   procedure EinheitenDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   procedure StädteDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );



   function BasiszeitwertEinheiten is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => EinheitenDatentypen.EinheitenbereichVorhanden);

   function BasiszeitwertStädte is new AllgemeineBerechnungen.Basiszeitwert (GanzeZahl => Positive);

end KILogik;
