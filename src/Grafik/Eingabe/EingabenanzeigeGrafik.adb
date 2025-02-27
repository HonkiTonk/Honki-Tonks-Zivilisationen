with Sf.Graphics.Text;

with EinheitenDatentypen;
with Spieltexte;
with Views;
with TextaccessVariablen;
with ViewKonstanten;
with TextnummernKonstanten;
with EinheitenKonstanten;
with GrafikKonstanten;

with LeseEinheitenGebaut;
with LeseLogiktask;
with LeseGrafiktask;

with EinheitenbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with InteraktionAuswahl;
with TextberechnungenBreiteGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextskalierungGrafik;

-- Die Viewflächen hier alle in ein Array umwandeln? äöü
package body EingabenanzeigeGrafik is
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesPositive;
      EingabeExtern : in GrafikDatentypen.Eingabe_Fragen_Enum)
   is begin
      
      Frage (HintergrundExtern => GrafikDatentypen.Auswahl_Enum,
             FrageExtern       => To_Wide_Wide_String (Source => Spieltexte.Fragen (FrageExtern)));
      
      case
        EingabeExtern
      is
         when GrafikDatentypen.Text_Eingabe_Enum =>
            AnzeigeText;
            
         when GrafikDatentypen.Zahlen_Eingabe_Enum =>
            AnzeigeGanzeZahl;
            
         when GrafikDatentypen.Ja_Nein_Enum =>
            AnzeigeJaNein;
            
         when GrafikDatentypen.Zeichen_Eingabe_Enum =>
            -- Wird für die Frageanzeige verwendet, wenn eine neue Taste belegt werden soll.
            -- Kann man das vielleicht entfernen oder erweitern?
            null;
      end case;
      
   end Fragenaufteilung;
   
   
   
   procedure Frage
     (HintergrundExtern : in GrafikDatentypen.Hintergrund_Anzeige_Durchsichtig_Enum;
      FrageExtern : in Wide_Wide_String)
   is begin
      
      FrageViewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => FrageViewfläche,
                                                                             VerhältnisExtern => (GrafikRecordKonstanten.Fragenbereich.width, GrafikRecordKonstanten.Fragenbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Frage),
                                            GrößeExtern          => FrageViewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Fragenbereich);
            
      HintergrundGrafik.Aufteilung (HintergrundExtern => HintergrundExtern,
                                    AbmessungenExtern => FrageViewfläche);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.ÜberschriftAccess,
                                         str  => FrageExtern);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                              ViewbreiteExtern => FrageViewfläche.x);
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                 PositionExtern   => Textposition);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ÜberschriftAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);

      FrageViewfläche := (Textbreite, Textposition.y);
      
   end Frage;
   
   

   procedure AnzeigeGanzeZahl
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Eingabebereich.width, GrafikRecordKonstanten.Eingabebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Antwort),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
            
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Auswahl_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      case
        LeseGrafiktask.Vorzeicheneingabe
      is
         when False =>
            Text := To_Unbounded_Wide_Wide_String (Source => "-") & ZahlAlsString (ZahlExtern => LeseGrafiktask.Zahleneingabe);
            
         when True =>
            Text := To_Unbounded_Wide_Wide_String (Source => ZahlAlsString (ZahlExtern => LeseGrafiktask.Zahleneingabe));       
      end case;
                                    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EingabenanzeigeAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EingabenanzeigeAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.EingabenanzeigeAccess,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.EingabenanzeigeAccess,
                                                                 PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Eingabebereich.width, GrafikRecordKonstanten.Eingabebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Antwort),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
            
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Auswahl_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.EingabenanzeigeAccess,
                                         str  => To_Wide_Wide_String (Source => LeseLogiktask.Texteingabe));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.EingabenanzeigeAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.EingabenanzeigeAccess,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      TextaccessverwaltungssystemEinfachGrafik.Standardskalierung (TextaccessExtern => TextaccessVariablen.EingabenanzeigeAccess);
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.EingabenanzeigeAccess,
                                                                 PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeText;
   
   
   
   procedure AnzeigeJaNein
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.JaNeinBereich.width, GrafikRecordKonstanten.JaNeinBereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Antwort),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.JaNeinBereich);
            
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Auswahl_Enum,
                                    AbmessungenExtern => Viewfläche);
            
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      AktuelleAuswahl := LeseGrafiktask.Zweitauswahl;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                                 ViewbreiteExtern => Viewfläche.x);
         
         TextaccessverwaltungssystemEinfachGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                         PositionExtern   => Textposition,
                                                                         FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert,
                                                                                                                                    AuswahlExtern    => AktuelleAuswahl));
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
         
         
         InteraktionAuswahl.PositionenJaNein (TextSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.JaNeinAccess (TextSchleifenwert));
         
      end loop TextSchleife;
            
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeJaNein;
   
   
   
   -- Möglicherweise würde das funktionieren, wenn ich die IDs auch schon außerhalb festlege? äöü
   procedure AnzeigeEinheitenStadt
     (SpeziesStadtnameExtern : in EinheitenGrafikRecords.SpeziesStadtnameGrafikRecord;
      WelcheAuswahlExtern : in EinheitenRecords.AuswahlRecord;
      AktuelleAuswahlExtern : in Integer)
   is
      use type EinheitenDatentypen.Transportplätze;
      use type EinheitenDatentypen.Einheitenbereich;
   begin
      
      -- Das hier dynamisch an die Auswahlmöglichkeiten anpassen? äöü
      -- Ähnliches System wie für die Tippsfläche bauen? äöü
      case
        WelcheAuswahlExtern.StadtEinheit
      is
         when True =>
            Anzeigebereich := GrafikRecordKonstanten.StadtEinheitAuswahlbereich (ViewKonstanten.AuswahlbereichStadt);
            
         when False =>
            Anzeigebereich := GrafikRecordKonstanten.StadtEinheitAuswahlbereich (ViewKonstanten.AuswahlbereichEinheit);
      end case;
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (Anzeigebereich.width, Anzeigebereich.height));
            
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtEinheitviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => Anzeigebereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Auswahl_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textbreite := GrafikKonstanten.Nullwert;
      MaximaleTextbreite := Viewfläche.x;
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in WelcheAuswahlExtern.MöglicheAuswahlen'Range loop
         
         if
           WelcheAuswahlExtern.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenKonstanten.LeerNummer
         then
            null;
            
         elsif
           AuswahlSchleifenwert = WelcheAuswahlExtern.MöglicheAuswahlen'First
           and
             WelcheAuswahlExtern.StadtEinheit = True
         then
            Text := SpeziesStadtnameExtern.Stadtname;
            
         else
            Text := To_Unbounded_Wide_Wide_String (Source => EinheitenbeschreibungenGrafik.Kurzbeschreibung
                                                   (IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesStadtnameExtern.Spezies, WelcheAuswahlExtern.MöglicheAuswahlen (AuswahlSchleifenwert))),
                                                    SpeziesExtern => SpeziesStadtnameExtern.Spezies));
         end if;
         
         if
           WelcheAuswahlExtern.MöglicheAuswahlen (AuswahlSchleifenwert) = EinheitenKonstanten.LeerNummer
         then
            null;
            
         else
            TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                TextExtern       => To_Wide_Wide_String (Source => Text),
                                                                FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Natural (AuswahlSchleifenwert),
                                                                                                                           AuswahlExtern    => AktuelleAuswahlExtern));
            
            Textbox := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            if
              Textbox.width <= GrafikKonstanten.Nullwert
              or
                Textbox.height <= GrafikKonstanten.Nullwert
            then
               if
                 AuswahlSchleifenwert = WelcheAuswahlExtern.MöglicheAuswahlen'First
               then
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugStadt)));
                  
               else
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Spieltexte.Zeug (TextnummernKonstanten.ZeugEinheit)));
               end if;
               
            else
               null;
            end if;
                        
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnenGlobaleGrenzen (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                                  ViewbreiteExtern => Viewfläche.x);
            
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
      
            Skalierung.x := TextskalierungGrafik.Verkleinerung (AktuelleBreiteExtern => Textbreite,
                                                                ErlaubteBreiteExtern => MaximaleTextbreite);
            Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
            
            -- Das nicht entfernen, ist für eine bessere Skalierung notwendig.
            -- Eventuell noch an anderen Stellen einbauen. äöü
            if
              Textbreite > MaximaleTextbreite
            then
               Textbreite := MaximaleTextbreite;
               
            else
               null;
            end if;
            
            TextaccessverwaltungssystemEinfachGrafik.PositionSkalierenZeichnen (TextaccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                PositionExtern   => Textposition,
                                                                                SkalierungExtern => Skalierung);
            
            InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
         end if;
         
      end loop AuswahlSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
            
   end AnzeigeEinheitenStadt;

end EingabenanzeigeGrafik;
