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
   PrüfungErfolgreich : Boolean;
   Zwischenprüfung : Boolean;

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

   procedure Ladevorgang
     (DateiLadenExtern : in File_Type);



   function Prüfen
     (DateiLadenExtern : in File_Type)
      return Boolean;

   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function AllgemeinesLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function RassenwerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

   function Rassenwerte
     (LadenPrüfenExtern : in Boolean;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean;

end LadenLogik;
