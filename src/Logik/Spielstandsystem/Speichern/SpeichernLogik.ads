private with Ada.Streams.Stream_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;
private with EinheitenDatentypen;
private with ZahlenDatentypen;
private with SystemDatentypen;

private with LeseSpeziesbelegung;

package SpeichernLogik is
   pragma Elaborate_Body;

   procedure Speichern
     (AutospeichernExtern : in Boolean;
      NotfallspeichernExtern : in Boolean)
     with
       Pre => (
                 if NotfallspeichernExtern then AutospeichernExtern
              );

   procedure AutoSpeichern;

private
   use Ada.Streams.Stream_IO;
   use Ada.Strings.Wide_Wide_Unbounded;
   use type SpeziesDatentypen.Spieler_Enum;

   Spielstandart : SystemDatentypen.Spielstand_Enum;

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
