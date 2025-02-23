private with Ada.Streams.Stream_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;
private with KartenRecords;
private with SpielRecords;
private with StadtRecords;
private with EinheitenRecords;
private with StadtDatentypen;
private with EinheitenDatentypen;

package LadenLogik is
   pragma Elaborate_Body;

   function Laden
     return Boolean;

private
   use Ada.Streams.Stream_IO;
   use Ada.Strings.Wide_Wide_Unbounded;
   use type SpeziesDatentypen.Spieler_Enum;

   Leerwert : Boolean;
   Zwischenprüfung : Boolean;

   DateiLaden : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;

   Wichtiges : SpielRecords.WichtigesRecord;

   Diplomatie : SpielRecords.DiplomatieRecord;

   Grenzen : SpielRecords.GrenzenRecord;

   Zeiger : KartenRecords.ZeigerRecord;

   Stadt : StadtRecords.StadtGebautRecord;

   Einheit : EinheitenRecords.EinheitenGebautRecord;

   Allgemeines : SpielRecords.AllgemeinesRecord;

   Speziesbelegung : SpielRecords.SpeziesbelegungArray;

   VorhandeneStädte : StadtDatentypen.Städtebereich;

   VorhandeneEinheiten : EinheitenDatentypen.Einheitenbereich;

   procedure Ladevorgang
     (DateiLadenExtern : in File_Type);



   function Prüfen
     (DateiLadenExtern : in File_Type)
      return Boolean;

   function AllgemeinesLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function StädteEinheitenLaden
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function Spezieswerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;

end LadenLogik;
