private with AllgemeinberechnungenHTB7;

with SpeziesDatentypen;

private with EinheitenDatentypen;
private with StadtDatentypen;

with LeseSpeziesbelegung;

package KILogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure KI
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   Städtezeitwert : StadtDatentypen.StädtebereichVorhanden;

   Einheitenzeitwert : EinheitenDatentypen.EinheitenbereichVorhanden;

   procedure EinheitenDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

   procedure StädteDurchgehen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );



   function BasiszeitwertEinheiten is new AllgemeinberechnungenHTB7.Basiszeitwert (GanzeZahl => EinheitenDatentypen.EinheitenbereichVorhanden);

   function BasiszeitwertStädte is new AllgemeinberechnungenHTB7.Basiszeitwert (GanzeZahl => Positive);

end KILogik;
