pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;
with EinheitStadtRecords;
with SystemRecords;
with KartenRecords;
with WichtigeRecords;
with SystemKonstanten;
with SonstigesKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with EinheitStadtDatentypen;

package GlobaleVariablen is

   -- Schreiben/Ausgabe
   -- Die einzelnen Textarrays hier rein oder in eine eigene Datei?
   type NutzerEinstellungenArray is array (1 .. 3) of Unbounded_Wide_Wide_String;
   NutzerEinstellungen : SystemRecords.NutzerEinstellungenRecord := (
                                                                     -- Sprache
                                                                     SystemKonstanten.LeerUnboundedString,
                                                                     -- Anzahl Autosaves
                                                                     10,
                                                                     -- Rundenanzahl bis Autosave
                                                                     10
                                                                    );
   
   AnzeigeArt : SystemDatentypen.Anzeige_Art_Enum := SystemDatentypen.Grafik_SFML;
   -- Schreiben/Ausgabe
   
   
   
   -- Schlechte Lösung für die Umbelegung der Steuerung
   UmbelegungNummer : Positive;
   -- Schlechte Lösung für die Umbelegung der Steuerung
   
   

   -- Cursor
   type CursorImSpielArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of KartenRecords.CursorRecord;
   CursorImSpiel : CursorImSpielArray := (others => SonstigesKonstanten.LeerCursor);
   -- Cursor
   
   

   -- Zeug
   Debug : Boolean := True;
   
   RundenAnzahl : Positive := Positive'First;
   Rundengrenze : Natural := Natural'First;

   -- Nicht belegt, Menschlicher Spieler, KI
   RassenImSpiel : SystemDatentypen.RassenImSpielArray := (others => SystemDatentypen.Leer);
   RasseAmZugNachLaden : SystemDatentypen.Rassen_Enum := EinheitenKonstanten.LeerRasse;

   Schwierigkeitsgrad : SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum;
   Gewonnen : Boolean := False;
   WeiterSpielen : Boolean := False;
   
   -- Später über Nutzereingaben neu belegbar machen.
   type GrenzenArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.GrenzenRecord;
   Grenzen : GrenzenArray := (others => SonstigesKonstanten.LeerGrenzen);
   
   IronmanName : Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => SystemKonstanten.LeerString);
   -- Zeug
   

   
   -- Einheiten
   type EinheitenGebautArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleEinheiten'Range) of EinheitStadtRecords.EinheitenGebautRecord;
   EinheitenGebaut : EinheitenGebautArray := (others => (others => EinheitenKonstanten.LeerEinheit));
   -- Einheiten
   
   

   -- Städte
   type StadtGebautArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, EinheitStadtDatentypen.MaximaleStädte'Range) of EinheitStadtRecords.StadtGebautRecord;
   StadtGebaut : StadtGebautArray := (others => (others => StadtKonstanten.LeerStadt));
   -- Städte
   
   

   -- Wichtiges Zeug
   type WichtigesArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.WichtigesRecord;
   Wichtiges : WichtigesArray := (others => SonstigesKonstanten.LeerWichtigesZeug);
   
   type DiplomatieArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range, SystemDatentypen.Rassen_Verwendet_Enum'Range) of WichtigeRecords.DiplomatieRecord;
   Diplomatie : DiplomatieArray := (others => (others => SonstigesKonstanten.LeerDiplomatie));
   -- Wichtiges Zeug
                                               
end GlobaleVariablen;
