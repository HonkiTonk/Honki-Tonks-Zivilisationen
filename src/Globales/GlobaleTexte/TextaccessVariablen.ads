with Sf.Graphics;
with Sf.Graphics.Text;

with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with MenueKonstanten;
with MenueDatentypen;
with Sequenzentexte;
with TextDatentypen;

with InteraktionAuswahl;

-- Auch mal thematisch aufteilen? äöü
package TextaccessVariablen is
   pragma Elaborate_Body;
   
   -- Allgemeines
   ÜberschriftAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   VersionsnummerAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   -- TexthöheAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
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
   
   SteuerungAccess : constant TextaccessArray (1 .. MenueKonstanten.LängstesMenü) := (others => Sf.Graphics.Text.create);
   
   SpielstandAccess : constant TextaccessArray (InteraktionAuswahl.PositionenSpielstand'Range) := (others => Sf.Graphics.Text.create);
   -- Menüs
   
   
   
   -- Zusatztexte
   ZusatztextKartengrößeAccess : constant TextaccessArray (1 .. 2) := (others => Sf.Graphics.Text.create);
   
   ZusatztextDiplomatieAccess : constant TextaccessArray (1 .. 2) := (others => Sf.Graphics.Text.create);
   -- Zusatztexte
   
   
   
   -- Speziestexte
   type SpeziesArray is array (SpeziesDatentypen.Spezies_Vorhanden_Enum'Range) of Sf.Graphics.sfText_Ptr;
   SpeziesnamenAccess : constant SpeziesArray := (others => Sf.Graphics.Text.create);
   SpeziesbeschreibungAccess : constant SpeziesArray := (others => Sf.Graphics.Text.create);
   
   
   
   GebäudeaufteilungAccess : constant TextaccessArray (InteraktionAuswahl.PositionenBauaufteilung'Range) := (others => Sf.Graphics.Text.create);
      
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
   
   
   
   -- Sprachauswahl
   SprachauswahlAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Sprachauswahl
   
   
   
   -- Kartenformauswahl
   KartenformauswahlAccess : constant TextaccessArray (1 .. MenueKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum)) := (others => Sf.Graphics.Text.create);
   -- Kartenformauswahl

   
   
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
   
   
   
   -- Karte
   KarteAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Karte
   
   
   
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
   LadezeitenAccess : constant TextaccessArray (2 .. 9) := (others => Sf.Graphics.Text.create);
   
   KIZeitenAccess : constant TextaccessArray (LadezeitenAccess'Last + 1 .. 13) := (others => Sf.Graphics.Text.create);
   
   RundenendeAccess : constant TextaccessArray (1 .. 1) := (others => Sf.Graphics.Text.create);
   
   SpeichernLadenAccess : constant TextaccessArray (1 .. 1) := (others => Sf.Graphics.Text.create);
   -- Ladezeiten

end TextaccessVariablen;
