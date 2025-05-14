with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with SystemDatentypenHTSEB;

with SpeziesDatentypen;

private with StadtDatentypen;

with LeseSpeziesbelegung;

package SpeichernStaedteLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Städte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Belegung : SpeziesDatentypen.Spieler_Belegt_Enum;

   VorhandeneStädte : StadtDatentypen.Städtebereich;
   
   AktuelleBewirtschaftung : SystemDatentypenHTSEB.EinByte;
   VorhandeneBewirtschaftung : SystemDatentypenHTSEB.EinByte;
   
   AktuellesGebäude : SystemDatentypenHTSEB.VierByte;
   VorhandeneGebäude : SystemDatentypenHTSEB.VierByte;
   
   
   
   function Städtewerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type;
      StädtebereichExtern : in StadtDatentypen.Städtebereich)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end SpeichernStaedteLogik;
