with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;
private with StadtDatentypen;
private with EinheitenDatentypen;
private with ZahlenDatentypen;

private with LeseSpeziesbelegung;

package SpeichernLogik is
   pragma Elaborate_Body;

   procedure Speichern
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private
   use type SpeziesDatentypen.Spieler_Enum;

   VorhandeneStädte : StadtDatentypen.Städtebereich;

   VorhandeneEinheiten : EinheitenDatentypen.Einheitenbereich;

   AktuellerAutospeichernwert : ZahlenDatentypen.EigenesPositive;

   MaximalerAutospeichernwert : Natural;

   DateiSpeichern : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;
   Autospeichernname : Unbounded_Wide_Wide_String;



   function Allgemeines
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

   function SpezieswerteSpeichern
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

   function StädteEinheitenSpeichern
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function Spezieswerte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String;

end SpeichernLogik;
