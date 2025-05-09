with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

with SpeziesDatentypen;
with SystemDatentypen;
with ForschungenDatentypen;

with LeseSpeziesbelegung;

package SpeichernSpezienspezifischesLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function Aufteilung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

private

   ForschungVorhanden : SystemDatentypen.VierByte;
   AktuellerForschungswert : SystemDatentypen.VierByte;

   -- Solle sich die Anzahl der Forschungen nicht zu weit erhöhen könnte man das auch als 2 statt 4 Bytes speichern und noch einmal 2 Byte pro Speicherung sparen.
   type ForschungsbereichArray is array (1 .. 3) of ForschungenDatentypen.ForschungIDVorhanden;
   Forschunganfang : constant ForschungsbereichArray := (1 => ForschungenDatentypen.ForschungIDVorhanden'First,
                                                         2 => 33,
                                                         3 => 65);

   Forschungsende : constant ForschungsbereichArray := (1 => 32,
                                                        2 => 64,
                                                        3 => ForschungenDatentypen.ForschungIDVorhanden'Last);



   function Grenzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Wichtiges
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end SpeichernSpezienspezifischesLogik;
