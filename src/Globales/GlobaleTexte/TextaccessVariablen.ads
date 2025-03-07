with Sf.Graphics;
with Sf.Graphics.Text;

with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with Sequenzentexte;
with TextDatentypen;
with Spieltexte;
with Kartentexte;
with Menuetexte;

with InteraktionAuswahl;

-- Auch mal thematisch aufteilen? äöü
package TextaccessVariablen is
   pragma Elaborate_Body;
   
   -- Allgemeines
   TestKleinAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   TestMittelAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   TestGroßAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   ÜberschriftAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   VersionsnummerAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
      
   ZeilenumbruchAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   BildrateAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   DiplomatieAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   EingabenanzeigeAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   EinheitenbauinformationenAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   GebäudebauinformationenAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   StadtkarteAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   StadtumgebungAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   -- Debug, mal anpassen. äöü
   EinheitenseitenleisteAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Debug, mal anpassen. äöü
   
   type TexthöhenaccessArray is array (TextDatentypen.Schriftgröße_Enum'Range) of Sf.Graphics.sfText_Ptr;
   TexthöhenAccess : constant TexthöhenaccessArray := (others => Sf.Graphics.Text.create);
   
   -- Für alle Varianten undefinierte Arrays anlegen? äöü
   -- Für die Arrays hier (und eventuell auch bei anderen Dingen) auch noch Konstante anlegen, damit ich die dann einfacher verwenden kann, wo beispielsweise keine Schleife möglich ist? äöü
   type TextaccessArray is array (Positive range <>) of Sf.Graphics.sfText_Ptr;
   
   IntroAccess : constant TextaccessArray (Positive'First .. Sequenzentexte.IntroEnde) := (others => Sf.Graphics.Text.create);
   OutroAccess : constant TextaccessArray (Positive'First .. Sequenzentexte.OutroEnde) := (others => Sf.Graphics.Text.create);
   -- Allgemeines

   
   
   -- Menüs
   type MenüsAccessArray is array (InteraktionAuswahl.PositionenMenüeinträgeArray'Range (1), InteraktionAuswahl.PositionenMenüeinträgeArray'Range (2)) of Sf.Graphics.sfText_Ptr;
   MenüsAccess : constant MenüsAccessArray := (others => (others => Sf.Graphics.Text.create));
   
   -- Ohne Überschrift.
   HauptmenüAccess : constant TextaccessArray (Menuetexte.Hauptmenü'Range) := (others => Sf.Graphics.Text.create);
   SpielmenüAccess : constant TextaccessArray (Menuetexte.Spielmenü'Range) := (others => Sf.Graphics.Text.create);
                               
   -- Mit Überschrift.
   OptionsmenüAccess : constant TextaccessArray (Menuetexte.Optionsmenü'Range) := (others => Sf.Graphics.Text.create);
   EinstellungsmenüAccess : constant TextaccessArray (Menuetexte.Einstellungsmenü'Range) := (others => Sf.Graphics.Text.create);
   EditorenmenüAccess : constant TextaccessArray (Menuetexte.Editorenmenü'Range) := (others => Sf.Graphics.Text.create);
   SpieleinstellungsmenüAccess : constant TextaccessArray (Menuetexte.Spieleinstellungsmenü'Range) := (others => Sf.Graphics.Text.create);
   DebugmenüAccess : constant TextaccessArray (Menuetexte.Debugmenü'Range) := (others => Sf.Graphics.Text.create);
   GrafikmenüAccess : constant TextaccessArray (Menuetexte.Grafikmenü'Range) := (others => Sf.Graphics.Text.create);
   KartengrößeAccess : constant TextaccessArray (Menuetexte.Kartengröße'Range) := (others => Sf.Graphics.Text.create);
   KartenartAccess : constant TextaccessArray (Menuetexte.Kartenart'Range) := (others => Sf.Graphics.Text.create);
   KartentemperaturAccess : constant TextaccessArray (Menuetexte.Kartentemperatur'Range) := (others => Sf.Graphics.Text.create);
   SchwierigkeitsgradAccess : constant TextaccessArray (Menuetexte.Schwierigkeitsgrad'Range) := (others => Sf.Graphics.Text.create);
   RessourcenmengeAccess : constant TextaccessArray (Menuetexte.Ressourcenmenge'Range) := (others => Sf.Graphics.Text.create);
   DiplomatiemenüAccess : constant TextaccessArray (Menuetexte.Diplomatiemenü'Range) := (others => Sf.Graphics.Text.create);
   KartenpoleAccess : constant TextaccessArray (Menuetexte.Kartenpole'Range) := (others => Sf.Graphics.Text.create);
   SoundmenüAccess : constant TextaccessArray (Menuetexte.Soundmenü'Range) := (others => Sf.Graphics.Text.create);
   HandelsmenüAccess : constant TextaccessArray (Menuetexte.Handelsmenü'Range) := (others => Sf.Graphics.Text.create);
                               
   -- Doppelte Menüs.
   SpeziesauswahlAccess : constant TextaccessArray (Menuetexte.Speziesauswahl'Range) := (others => Sf.Graphics.Text.create);
   KartenformAccess : constant TextaccessArray (Menuetexte.Kartenform'Range) := (others => Sf.Graphics.Text.create);
   
   -- Steuerungsmenü.
   SteuerungAccess : constant TextaccessArray (Menuetexte.Steuerungsmenü'Range) := (others => Sf.Graphics.Text.create);
   
   -- SpeichernLadenmenü
   SpielstandAccess : constant TextaccessArray (InteraktionAuswahl.PositionenSpielstand'Range) := (others => Sf.Graphics.Text.create);
   -- Menüs
   
   
   
   -- Kartentexte
   BasisgrundAccess : constant TextaccessArray (Kartentexte.Basisgrund'Range) := (others => Sf.Graphics.Text.create);
   ZusatzgrundAccess : constant TextaccessArray (Kartentexte.Zusatzgrund'Range) := (others => Sf.Graphics.Text.create);
   
   FlüsseAccess : constant TextaccessArray (Kartentexte.Flüsse'Range) := (others => Sf.Graphics.Text.create);
   RessourcenAccess : constant TextaccessArray (Kartentexte.Ressourcen'Range) := (others => Sf.Graphics.Text.create);
   FeldeffekteAccess : constant TextaccessArray (Kartentexte.Feldeffekte'Range) := (others => Sf.Graphics.Text.create);
   
   VerbesserungenAccess : constant TextaccessArray (Kartentexte.Verbesserungen'Range) := (others => Sf.Graphics.Text.create);
   WegeAccess : constant TextaccessArray (Kartentexte.Wege'Range) := (others => Sf.Graphics.Text.create);
   
   
   
   StadtnameKarteAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Kartentexte
   
   
   
   -- Spieltexte
   ZeugAccess : constant TextaccessArray (Spieltexte.Zeug'Range) := (others => Sf.Graphics.Text.create);
   FragenAccess : constant TextaccessArray (Spieltexte.Fragen'Range) := (others => Sf.Graphics.Text.create);
   MeldungenAccess : constant TextaccessArray (Spieltexte.Meldungen'Range) := (others => Sf.Graphics.Text.create);
   
   WürdigungenAccess : constant TextaccessArray (Spieltexte.Würdigungen'Range) := (others => Sf.Graphics.Text.create);
   
   -- StadtbefehleAccess : constant TextaccessArray (Spieltexte.Stadtbefehle'Range) := (others => Sf.Graphics.Text.create);
   -- LadezeitenAccess : constant TextaccessArray (Spieltexte.Ladezeiten'Range) := (others => Sf.Graphics.Text.create);
   BeschäftigungenAccess : constant TextaccessArray (Spieltexte.Beschäftigungen'Range) := (others => Sf.Graphics.Text.create);
   -- Spieltexte
   
   
   
   -- Zusatztexte
   ZusatztextKartengrößeAccess : constant TextaccessArray (1 .. 2) := (others => Sf.Graphics.Text.create);
   
   ZusatztextDiplomatieAccess : constant TextaccessArray (1 .. 2) := (others => Sf.Graphics.Text.create);
   -- Zusatztexte
   
   
   
   -- Speziestexte
   type SpeziesArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of Sf.Graphics.sfText_Ptr;
   SpeziesnamenAccess : constant SpeziesArray := (others => Sf.Graphics.Text.create);
   SpeziesbeschreibungAccess : constant SpeziesArray := (others => Sf.Graphics.Text.create);
   
   
   
   type GebäudeaufteilungAccessArray is array (InteraktionAuswahl.PositionenBauaufteilung'Range) of Sf.Graphics.sfText_Ptr;
   GebäudeaufteilungAccess : constant GebäudeaufteilungAccessArray := (others => Sf.Graphics.Text.create);
      
   type GebäudetextAccessArray is array (SpeziesnamenAccess'Range, StadtDatentypen.GebäudeID'Range) of Sf.Graphics.sfText_Ptr;
   GebäudetextAccess : constant GebäudetextAccessArray := (others => (others => Sf.Graphics.Text.create));

   type GebäudezusatztextAccessArray is array (SpeziesnamenAccess'Range, StadtDatentypen.GebäudeIDVorhanden'Range) of Sf.Graphics.sfText_Ptr;
   GebäudezusatztextAccess : constant GebäudezusatztextAccessArray := (others => (others => Sf.Graphics.Text.create));
   
   

   type EinheitentextAccessArray is array (SpeziesnamenAccess'Range, EinheitenDatentypen.EinheitenID'Range) of Sf.Graphics.sfText_Ptr;
   EinheitentextAccess : constant EinheitentextAccessArray := (others => (others => Sf.Graphics.Text.create));

   type EinheitenzusatztextAccessArray is array (SpeziesnamenAccess'Range, EinheitenDatentypen.EinheitenIDVorhanden'Range) of Sf.Graphics.sfText_Ptr;
   EinheitenzusatztextAccess : constant EinheitenzusatztextAccessArray := (others => (others => Sf.Graphics.Text.create));
   
   AktuellesBauprojekt : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   
   
   type ForschungsmenüAccessArray is array (SpeziesnamenAccess'Range, ForschungenDatentypen.ForschungIDVorhanden'Range) of Sf.Graphics.sfText_Ptr;
   ForschungsmenüAccess : constant ForschungsmenüAccessArray := (others => (others => Sf.Graphics.Text.create));
   
   type ForschungsmenüZusatztextAccessArray is array (SpeziesnamenAccess'Range, ForschungsmenüAccessArray'Range (2)) of Sf.Graphics.sfText_Ptr;
   ForschungsmenüZusatztextAccess : constant ForschungsmenüZusatztextAccessArray := (others => (others => Sf.Graphics.Text.create));
   
   ForschungsmenüErmöglichtAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   AktuellesForschungsprojekt : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Forschungsmenü
   
   
   
   -- Setauswahl
   SetauswahlAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Setauswahl

   
   
   -- StadtInformationen
   StadtInformationenAccess : constant TextaccessArray (1 .. 9) := (others => Sf.Graphics.Text.create);
   -- StadtInformationen
   
   
   
   -- EinheitenInformationen
   EinheitenInformationenAccess : constant TextaccessArray (1 .. 9) := (others => Sf.Graphics.Text.create);
   -- EinheitenInformationen
   
      
   
   -- KarteWichtiges
   KarteWichtigesAccess : constant TextaccessArray (1 .. 4) := (others => Sf.Graphics.Text.create);
   -- KarteWichtiges
   
   
   
   -- KarteAllgemeines
   KarteAllgemeinesAccess : constant TextaccessArray (1 .. 6) := (others => Sf.Graphics.Text.create);
   -- KarteAllgemeines
   
   
   
   -- AnzeigeEingabe
   type AnzeigeEinheitStadtAccessArray is array (InteraktionAuswahl.PositionenEinheitStadtArray'Range) of Sf.Graphics.sfText_Ptr;
   AnzeigeEinheitStadtAccess : constant AnzeigeEinheitStadtAccessArray := (others => Sf.Graphics.Text.create);
   
   type JaNeinAccessArray is array (InteraktionAuswahl.PositionenJaNein'Range) of Sf.Graphics.sfText_Ptr;
   JaNeinAccess : constant JaNeinAccessArray := (others => Sf.Graphics.Text.create);
   
   Spielmeldung : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- AnzeigeEingabe
   
   
   
   -- Befehle
   type StadtbefehleAccessArray is array (InteraktionAuswahl.PositionenStadtbefehleArray'Range) of Sf.Graphics.sfText_Ptr;
   StadtbefehleAccess : constant StadtbefehleAccessArray := (others => Sf.Graphics.Text.create);
   -- Befehle
   
   
   
   -- Ladezeiten
   -- Immer an die Textdatei Ladezeiten anpassen. Wieso mache ich das nicht öfters/überhaupt? Sollte eine Menge Arbeit ersparen. äöü
   -- Kann das mit dem neuen Textsystem und den restlichen Änderungen nicht auf 1 .. X gesetzt werden? äöü
   -- Generell die Ladeanzeigen mal überarbeiten und das neue textanzeigesystem einbauen. äöü
   LadezeitenAccess : constant TextaccessArray (2 .. 9) := (others => Sf.Graphics.Text.create);
   
   KIZeitenAccess : constant TextaccessArray (LadezeitenAccess'Last + 1 .. 13) := (others => Sf.Graphics.Text.create);
   
   RundenendeAccess : constant TextaccessArray (1 .. 1) := (others => Sf.Graphics.Text.create);
   
   SpeichernLadenAccess : constant TextaccessArray (1 .. 1) := (others => Sf.Graphics.Text.create);
   -- Ladezeiten

end TextaccessVariablen;
