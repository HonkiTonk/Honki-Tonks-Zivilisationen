with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;

private with EinheitenDatentypen;
private with SystemDatentypen;

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
   
   Belegung : SpeziesDatentypen.Spieler_Belegt_Enum;

   ID : EinheitenDatentypen.EinheitenID;
   
   TransportplätzeBelegt : SystemDatentypen.EinByte;
   AktuelleTransportplatz : SystemDatentypen.EinByte;
   
   VorhandeneEinheiten : EinheitenDatentypen.Einheitenbereich;
   GeladeneEinheit : EinheitenDatentypen.Einheitenbereich;
   
   
   
   function Einheitenwerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type;
      EinheitenbereichExtern : in EinheitenDatentypen.Einheitenbereich)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end SpeichernEinheitenLogik;
