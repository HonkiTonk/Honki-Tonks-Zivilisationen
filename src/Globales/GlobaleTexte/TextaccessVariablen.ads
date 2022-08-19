pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics;
with Sf.Graphics.Text;

with RassenDatentypen;
with EinheitenDatentypen;
with StadtDatentypen;
with ForschungenDatentypen;
with SystemKonstanten;
with MenueDatentypen;

with InteraktionAuswahl;

package TextaccessVariablen is
   
   -- Allgemeines
   ÜberschriftAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   VersionsnummerAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   
   ZeilenumbruchAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Allgemeines

   -- MenüsEinfach
   -- Später entfernen! äöü
   Überschrift : constant Positive := 1;
   Versionsnummer : constant Positive := 1;
   
   -- Die ganzen Arrays mal so anpassen wie das MenüsEinfachSFMLAccessArray, bzw. soweit wie das möglich ist.
   type MenüsEinfachSFMLAccessArray is array (InteraktionAuswahl.PositionenMenüeinträgeArray'Range (1), InteraktionAuswahl.PositionenMenüeinträgeArray'Range (2)) of Sf.Graphics.sfText_Ptr;
   MenüsEinfachSFMLAccess : constant MenüsEinfachSFMLAccessArray := (others => (others => Sf.Graphics.Text.create));
   -- MenüsEinfach
   
   
   
   -- ZusatztextRassenmenü
   type RassennamenAccessArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Sf.Graphics.sfText_Ptr;
   RassennamenAccess : constant RassennamenAccessArray := (others => Sf.Graphics.Text.create);
   
   type RassenbeschreibungAccessArray is array (RassennamenAccessArray'Range) of Sf.Graphics.sfText_Ptr;
   RassenbeschreibungAccess : constant RassenbeschreibungAccessArray := (others => Sf.Graphics.Text.create);
   -- ZusatztextRassenmenü
   
   
   
   -- ZusatztextKartengröße
   type ZusatztextKartengrößeAccessArray is array (1 .. 2) of Sf.Graphics.sfText_Ptr;
   ZusatztextKartengrößeAccess : constant ZusatztextKartengrößeAccessArray := (others => Sf.Graphics.Text.create);
   -- ZusatztextKartengröße
   
   
   
   -- Baumenü
   type GebäudetextAccessArray is array (StadtDatentypen.GebäudeIDMitNullwert'Range) of Sf.Graphics.sfText_Ptr;
   GebäudetextAccess : constant GebäudetextAccessArray := (others => Sf.Graphics.Text.create);

   type GebäudezusatztextAccessArray is array (StadtDatentypen.GebäudeID'First .. GebäudetextAccessArray'Last) of Sf.Graphics.sfText_Ptr;
   GebäudezusatztextAccess : constant GebäudezusatztextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitentextAccessArray is array (EinheitenDatentypen.EinheitenIDMitNullWert'Range) of Sf.Graphics.sfText_Ptr;
   EinheitentextAccess : constant EinheitentextAccessArray := (others => Sf.Graphics.Text.create);

   type EinheitenzusatztextAccessArray is array (EinheitenDatentypen.EinheitenID'First .. EinheitentextAccessArray'Last) of Sf.Graphics.sfText_Ptr;
   EinheitenzusatztextAccess : constant EinheitenzusatztextAccessArray := (others => Sf.Graphics.Text.create);
   -- Baumenü
   
   
   
   -- Forschungsmenü
   type ForschungsmenüAccessArray is array (ForschungenDatentypen.ForschungID'Range) of Sf.Graphics.sfText_Ptr;
   ForschungsmenüAccess : constant ForschungsmenüAccessArray := (others => Sf.Graphics.Text.create);
   
   type ForschungsmenüZusatztextAccessArray is array (ForschungsmenüAccessArray'Range) of Sf.Graphics.sfText_Ptr;
   ForschungsmenüZusatztextAccess : constant ForschungsmenüZusatztextAccessArray := (others => Sf.Graphics.Text.create);
   
   ForschungsmenüErmöglichtAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Forschungsmenü
   
   
   
   -- Sprachauswahl
   SprachauswahlAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Sprachauswahl
   
   
   
   -- Kartenformauswahl
   Zusatzplatz : constant Positive := 16;
   
   type KartenformauswahlAccessArray is array (Überschrift .. SystemKonstanten.EndeMenü (MenueDatentypen.Kartenform_Menü_Enum) + Zusatzplatz + Versionsnummer) of Sf.Graphics.sfText_Ptr;
   KartenformauswahlAccess : constant KartenformauswahlAccessArray := (others => Sf.Graphics.Text.create);
   -- Kartenformauswahl

   
   
   -- StadtInformationen
   type StadtInformationenAccessArray is array (1 .. 13) of Sf.Graphics.sfText_Ptr;
   StadtInformationenAccess : constant StadtInformationenAccessArray := (others => Sf.Graphics.Text.create);
   -- StadtInformationen
   
   
   
   -- EinheitenInformationen
   type EinheitenInformationenAccessArray is array (1 .. 13) of Sf.Graphics.sfText_Ptr;
   EinheitenInformationenAccess : constant EinheitenInformationenAccessArray := (others => Sf.Graphics.Text.create);
   -- EinheitenInformationen
   
      
   
   -- KarteWichtiges
   type KarteWichtigesAccessArray is array (1 .. 8) of Sf.Graphics.sfText_Ptr;
   KarteWichtigesAccess : constant KarteWichtigesAccessArray := (others => Sf.Graphics.Text.create);
   -- KarteWichtiges
   
   
   
   -- KarteAllgemeines
   type KarteAllgemeinesAccessArray is array (1 .. 5) of Sf.Graphics.sfText_Ptr;
   KarteAllgemeinesAccess : constant KarteAllgemeinesAccessArray := (others => Sf.Graphics.Text.create);
   -- KarteAllgemeines
   
   
   
   -- Karte
   KarteAccess : constant Sf.Graphics.sfText_Ptr := Sf.Graphics.Text.create;
   -- Karte
   
   
   
   -- AnzeigeEingabe
   type AnzeigeZahlTexteingabeAccessArray is array (1 .. 2) of Sf.Graphics.sfText_Ptr;
   AnzeigeZahlTexteingabeAccess : constant AnzeigeZahlTexteingabeAccessArray := (others => Sf.Graphics.Text.create);
   
   type AnzeigeEinheitStadtAccessArray is array (InteraktionAuswahl.PositionenEinheitStadtArray'Range) of Sf.Graphics.sfText_Ptr;
   AnzeigeEinheitStadtAccess : constant AnzeigeEinheitStadtAccessArray := (others => Sf.Graphics.Text.create);
   
   type JaNeinAccessArray is array (1 .. 3) of Sf.Graphics.sfText_Ptr;
   JaNeinAccess : constant JaNeinAccessArray := (others => Sf.Graphics.Text.create);
   -- AnzeigeEingabe
   
   
   
   -- Ladezeiten
   -- Immer an die Textdatei Ladezeiten anpassen. Wieso mache ich das nicht öfters/überhaupt? Sollte eine Menge Arbeit ersparen. äöü
   type LadezeitenAccessArray is array (1 .. 9) of Sf.Graphics.sfText_Ptr;
   LadezeitenAccess : constant LadezeitenAccessArray := (others => Sf.Graphics.Text.create);
   
   type KIZeitenAccessArray is array (10 .. 15) of Sf.Graphics.sfText_Ptr;
   KIZeitenAccess : constant KIZeitenAccessArray := (others => Sf.Graphics.Text.create);
   
   type RundenendeAccessArray is array (1 .. 2) of Sf.Graphics.sfText_Ptr;
   RundenendeAccess : constant RundenendeAccessArray := (others => Sf.Graphics.Text.create);
   
   type SpeichernLadenAccessArray is array (1 .. 2) of Sf.Graphics.sfText_Ptr;
   SpeichernLadenAccess : constant SpeichernLadenAccessArray := (others => Sf.Graphics.Text.create);
   -- Ladezeiten

end TextaccessVariablen;
