with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

private with EinheitenDatentypen;

with LeseSpeziesbelegung;

package SpeichernEinheitenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private

   VorhandeneEinheiten : EinheitenDatentypen.Einheitenbereich;

end SpeichernEinheitenLogik;
