with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SystemRecords;
private with GrafikRecords;
private with TonRecords;
private with ZahlenDatentypen;

package EinlesenEinstellungenLogik is
   pragma Elaborate_Body;

   procedure EinlesenEinstellungen;
   
private
   
   Sprache : Unbounded_Wide_Wide_String;
   AnzahlAutospeichern : ZahlenDatentypen.EigenesNatural;
   RundenAutospeichern : ZahlenDatentypen.EigenesPositive;
   
   Nullwert : Boolean;
      
   DateiNutzereinstellungen : File_Type;
   DateiSoundeinstellungen : File_Type;
   DateiSonstigeEinstellungen : File_Type;
         
   ZwischenspeicherNutzereinstellungen : SystemRecords.NutzerEinstellungenRecord;
   
   Fenstereinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   ZwischenspeicherSonstigeEinstellungen : SystemRecords.SonstigeEinstellungenRecord;
   
   ZwischenspeicherGrafikeinstellungen : GrafikRecords.GrafikeinstellungenRecord;
   
   Soundeinstellungen : TonRecords.SoundeinstellungenRecord;
   
   Musikeinstellungen : TonRecords.MusikeinstellungenRecord;
   
   procedure Nutzereinstellungen;
   procedure Toneinstelllungen;
   procedure SonstigeEinstellungen;
   
   
   
   function NutzereinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function ToneinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;
   
   function SonstigeEinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenEinstellungenLogik;
