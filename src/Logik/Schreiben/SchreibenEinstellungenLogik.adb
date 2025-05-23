with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Exceptions; use Ada.Exceptions;

with DateizugriffssystemHTSEB;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with Sf.Window.Window;
with Sf.System.Vector2;
with Sf.Graphics.Color;
with Sf.Window.Keyboard;
with Sf.Graphics.Text;

with VerzeichnisKonstanten;
with ZahlenDatentypen;
with TextDatentypen;
with SpeziesDatentypen;
with TastenbelegungDatentypen;
with BefehleDatentypen;

with LeseOptionen;
with LeseEinstellungenGrafik;
with LeseEinstellungenTon;
with LeseTastenbelegungDatenbank;

with TexteinstellungenGrafik;

-- Beim Record kann ich theoretisch alles beliebig neu ordnen, beim Einlesen/Schreiben muss ich aber immer alles neue an das Ende anhängen!
-- Keine Schleifen einbauen, sonst wird das automatisch irgendwo dazwischen eingebaut und nicht am Ende wenn der Schleifenbereich erweitert wird!
package body SchreibenEinstellungenLogik is
   
   procedure Nutzereinstellungen
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiNutzereinstellungen,
                                                NameExtern     => VerzeichnisKonstanten.Spieleinstellungen);
      
      -- SystemRecords.NutzerEinstellungenRecord
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiNutzereinstellungen),
                                        LeseOptionen.Sprache);
      
      ZahlenDatentypen.EigenesNatural'Write (Stream (File => DateiNutzereinstellungen),
                                             LeseOptionen.AnzahlAutospeichern);
      
      ZahlenDatentypen.EigenesPositive'Write (Stream (File => DateiNutzereinstellungen),
                                              LeseOptionen.RundenAutospeichern);
      
      Wide_Wide_Character'Write (Stream (File => DateiNutzereinstellungen),
                                 LeseOptionen.Dezimaltrennzeichen);
      
      Boolean'Write (Stream (File => DateiNutzereinstellungen),
                     LeseOptionen.SicherheitsfragenAnzeigen);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiNutzereinstellungen),
                                        LeseOptionen.Texturen);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiNutzereinstellungen),
                                        LeseOptionen.Musik);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiNutzereinstellungen),
                                        LeseOptionen.Sound);
      -- SystemRecords.NutzerEinstellungenRecord
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiNutzereinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Spieleinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenEinstellungenLogik.Nutzereinstellungen: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiNutzereinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Spieleinstellungen);
      
   end Nutzereinstellungen;
   
   
   
   procedure Grafikeinstellungen
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiGrafikeinstellungen,
                                                NameExtern     => VerzeichnisKonstanten.Grafikeinstellungen);
      
      -- GrafikRecords.GrafikeinstellungenRecord
      Sf.Window.Window.sfWindowStyle'Write (Stream (File => DateiGrafikeinstellungen),
                                            LeseEinstellungenGrafik.Fenstermodus);
      
      Sf.System.Vector2.sfVector2u'Write (Stream (File => DateiGrafikeinstellungen),
                                          LeseEinstellungenGrafik.Auflösung);
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         LeseEinstellungenGrafik.Farbtiefe);
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         LeseEinstellungenGrafik.Bildrate);
      
      
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Überschrift_Enum));
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Standard_Enum));
      
      Sf.sfUint32'Write (Stream (File => DateiGrafikeinstellungen),
                         TexteinstellungenGrafik.SchriftgrößeLesen (WelcheGrößeExtern => TextDatentypen.Klein_Enum));
            
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Überschrift_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Mensch_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.KI_Enum));
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Sonstiges_Enum));
      
      Sf.Graphics.Text.sfTextStyle'Write (Stream (File => DateiGrafikeinstellungen),
                                          TexteinstellungenGrafik.SchriftstilLesen);
      
      
      
      -- Die Schleife kann ich hier verwenden, weil sich die Speziesanzahl nicht mehr ändern wird.
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
      
         Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                          LeseEinstellungenGrafik.SpeziesfarbeLesen (SpeziesExtern => SpeziesSchleifenwert));
         
      end loop SpeziesSchleife;
      
      
      
      Boolean'Write (Stream (File => DateiGrafikeinstellungen),
                     LeseEinstellungenGrafik.EbenenUnterhalbSichtbar);
      
      Boolean'Write (Stream (File => DateiGrafikeinstellungen),
                     LeseEinstellungenGrafik.BildrateAnzeigen);
      
      Sf.sfBool'Write (Stream (File => DateiGrafikeinstellungen),
                       LeseEinstellungenGrafik.VSync);
      
      Sf.Graphics.Color.sfColor'Write (Stream (File => DateiGrafikeinstellungen),
                                       TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum));
      
      Float'Write (Stream (File => DateiGrafikeinstellungen),
                   TexteinstellungenGrafik.SchriftrahmenLesen);
      -- GrafikRecords.GrafikeinstellungenRecord
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiGrafikeinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Grafikeinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenEinstellungenLogik.Grafikeinstellungen: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiGrafikeinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Grafikeinstellungen);
      
   end Grafikeinstellungen;
   
   
   
   procedure Toneinstellungen
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiToneinstellungen,
                                                NameExtern     => VerzeichnisKonstanten.Toneinstellungen);
      
      -- TonRecords.ToneinstellungenRecord
      Float'Write (Stream (File => DateiToneinstellungen),
                   LeseEinstellungenTon.Soundlautstärke);
      
      Float'Write (Stream (File => DateiToneinstellungen),
                   LeseEinstellungenTon.Musiklautstärke);
      -- TonRecords.ToneinstellungenRecord
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiToneinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Toneinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenEinstellungenLogik.Toneinstellungen: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiToneinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Toneinstellungen);
            
   end Toneinstellungen;
   
   

   -- Hier werden die Arrays nicht gleich komplett geschrieben, damit man sie bei einer Erweiterung hinten anhängen kann und die alten Einstellungen weiter verwenden kann.
   procedure Tastatureinstellungen
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiTastatureinstellungen,
                                                NameExtern     => VerzeichnisKonstanten.Tastatureinstellungen);
      
      -- TastenbelegungDatenbank.AllgemeineBelegungArray
      -- TastenbelegungDatenbank.EinheitenbelegungArray
      -- TastenbelegungDatenbank.StadtbelegungArray
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Auswählen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Oben_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Links_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Unten_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Rechts_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Links_Oben_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Rechts_Oben_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Links_Unten_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Rechts_Unten_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Ebene_Hoch_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Ebene_Runter_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Forschung_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Diplomatie_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Stadt_Suchen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Nächste_Stadt_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Nächste_Einheit_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Gehe_Zu_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Runde_Beenden_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Debugmenü_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Abwählen_Enum));
      
      
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Auswählen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Oben_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Links_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Unten_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Rechts_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Links_Oben_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Rechts_Oben_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Links_Unten_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Rechts_Unten_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Ebene_Hoch_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Ebene_Runter_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Bauen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Straße_Bauen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Mine_Bauen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Farm_Bauen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Festung_Bauen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Wald_Aufforsten_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Roden_Trockenlegen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Feldeffekte_Entfernen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Heilen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Verschanzen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Plündern_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Auflösen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Einheit_Verbessern_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Heimatstadt_Ändern_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Entladen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Abwählen_Enum));
      
      
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => BefehleDatentypen.Stadtkarte_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => BefehleDatentypen.Bauen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => BefehleDatentypen.Verkaufen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => BefehleDatentypen.Umbenennen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => BefehleDatentypen.Auflösen_Enum));
      
      Sf.Window.Keyboard.sfKeyCode'Write (Stream (File => DateiTastatureinstellungen),
                                          LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => BefehleDatentypen.Verlassen_Enum));
      -- TastenbelegungDatenbank.AllgemeineBelegungArray
      -- TastenbelegungDatenbank.EinheitenbelegungArray
      -- TastenbelegungDatenbank.StadtbelegungArray
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiTastatureinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Tastatureinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenEinstellungenLogik.Tastatureinstellungen: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiTastatureinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.Tastatureinstellungen);
   end Tastatureinstellungen;
   
   
   
   procedure SpielendeEinstellungen
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiSpielendeEinstellungen,
                                                NameExtern     => VerzeichnisKonstanten.SpielendeEinstellungen);
      
      -- SystemRecords.SpielendeEinstellungenRecord
      ZahlenDatentypen.EigenesPositive'Write (Stream (File => DateiSpielendeEinstellungen),
                                              LeseOptionen.AktuellerAutospeichernwert);
      -- SystemRecords.SpielendeEinstellungenRecord
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiSpielendeEinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.SpielendeEinstellungen);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenEinstellungenLogik.SpielendeEinstellungen: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiSpielendeEinstellungen,
                                                 NameExtern     => VerzeichnisKonstanten.SpielendeEinstellungen);
      
   end SpielendeEinstellungen;

end SchreibenEinstellungenLogik;
