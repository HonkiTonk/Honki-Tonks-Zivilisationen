with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with RassenDatentypen;
private with KartenRecords;
private with WeltkarteRecords;
private with SpielRecords;
private with StadtRecords;
private with EinheitenRecords;

package LadenLogik is
   pragma Elaborate_Body;

   function Laden
     return Boolean;

private
   use type RassenDatentypen.Spieler_Enum;

   Leerwert : Boolean;

   DateiLaden : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;

   Karteneinstellungen : KartenRecords.PermanenteKartenparameterRecord;

   Wichtiges : SpielRecords.WichtigesRecord;

   Diplomatie : SpielRecords.DiplomatieRecord;

   Grenzen : SpielRecords.GrenzenRecord;

   Cursor : KartenRecords.CursorRecord;

   Stadt : StadtRecords.StadtGebautRecord;

   Einheit : EinheitenRecords.EinheitenGebautRecord;

   Allgemeines : SpielRecords.AllgemeinesRecord;

   Rassenbelegung : SpielRecords.RassenbelegungArray;

   Karteneintrag : WeltkarteRecords.WeltkarteRecord;



   function Prüfen
     (DateiLadenExtern : in File_Type)
      return Boolean;

   function KarteLaden
     (PrüfenLadenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function AllgemeinesLaden
     (PrüfenLadenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function RassenwerteLaden
     (PrüfenLadenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function Rassenwerte
     (PrüfenLadenExtern : in Boolean;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;

end LadenLogik;
