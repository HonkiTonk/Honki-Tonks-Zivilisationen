pragma SPARK_Mode (On);

with TastenbelegungDatentypen;

package TastenbelegungKonstanten is

   LeerTastenbelegungKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Leer_Tastenbelegung;

   -- Bewegung
   ObenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Oben;
   LinksKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Links;
   UntenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Unten;
   RechtsKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Rechts;
   LinksObenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Links_Oben;
   RechtsObenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Rechts_Oben;
   LinksUntenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Links_Unten;
   RechtsUntenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Rechts_Unten;
   EbeneHochKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Ebene_Hoch;
   EbeneRunterKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Ebene_Runter;

   AuswählenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Auswählen;
   MenüZurückKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Menü_Zurück;
   BauenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Bauen;
   ForschungKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Forschung;
   TechBaumKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Tech_Baum;

   NächsteStadtKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Nächste_Stadt;
   EinheitMitBewegungspunkteKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte;
   AlleEinheitenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Alle_Einheiten;
   EinheitenOhneBewegungspunkteKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte;
   NächsteStadtMeldungKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung;
   NächsteEinheitMeldungKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung;

   -- Einheitenbefehle Verbesserungen
   StraßeBauenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Straße_Bauen;
   MineBauenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Mine_Bauen;
   FarmBauenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Farm_Bauen;
   FestungBauenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Festung_Bauen;
   WaldAufforstenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Wald_Aufforsten;
   RodenTrockenlegenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Roden_Trockenlegen;

   -- Einheitenbefehle allgemein
   HeilenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Heilen;
   VerschanzenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Verschanzen;
   RundeAussetzenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Runde_Aussetzen;
   PlündernKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Plündern;
   AuflösenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Auflösen;
   EinheitVerbessernKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Einheit_Verbessern;
   HeimatstadtÄndernKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Heimatstadt_Ändern;

   -- Sonstiges
   InfosKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Infos;
   DiplomatieKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Diplomatie;
   GeheZuKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.GeheZu;

   StadtUmbenennenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Stadt_Umbenennen;
   StadtAbreißenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Stadt_Abreißen;
   StadtSuchenKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Stadt_Suchen;

   RundeBeendenTastenbelegungKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Runde_Beenden;
   DebugmenüKonstante : constant TastenbelegungDatentypen.Tastenbelegung_Enum := TastenbelegungDatentypen.Debugmenü;

end TastenbelegungKonstanten;
