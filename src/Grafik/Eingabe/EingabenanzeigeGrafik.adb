with Sf.Graphics.Text;

with EinheitenDatentypen;
with Meldungstexte;
with Views;
with TextaccessVariablen;
with ViewKonstanten;
with TextnummernKonstanten;
with EinheitenKonstanten;
with GrafikKonstanten;

with LeseEinheitenGebaut;

with EinheitenbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with InteraktionAuswahl;
with TextberechnungenBreiteGrafik;
with NachLogiktask;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with NachGrafiktask;
with AllgemeineViewsGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemGrafik;
with TextskalierungGrafik;

package body EingabenanzeigeGrafik is
   
   procedure Fragenaufteilung
     (FrageExtern : in ZahlenDatentypen.EigenesPositive;
      EingabeExtern : in GrafikDatentypen.Eingaben_Fragen_Enum)
   is begin
      
      AllgemeineViewsGrafik.Frage (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                   FrageExtern       => To_Wide_Wide_String (Source => Meldungstexte.Frage (FrageExtern)));
      
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
            null;
      end case;
      
   end Fragenaufteilung;
   
   

   procedure AnzeigeGanzeZahl
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Eingabebereich.width, GrafikRecordKonstanten.Eingabebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Antwort),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      case
        NachGrafiktask.EingegebenesVorzeichen
      is
         when False =>
            Text := To_Unbounded_Wide_Wide_String (Source => "-") & ZahlAlsStringNatural (ZahlExtern => NachGrafiktask.EingegebeneZahl);
                              
         when True =>
            Text := ZahlAlsStringNatural (ZahlExtern => NachGrafiktask.EingegebeneZahl);       
      end case;
                                    
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => Text));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                          PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      -- Die Viewflächen auch in ein Array umwandeln?
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeGanzeZahl;
   
   
   
   procedure AnzeigeText
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Eingabebereich.width, GrafikRecordKonstanten.Eingabebereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Antwort),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Eingabebereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => To_Wide_Wide_String (Source => NachLogiktask.EingegebenerText.EingegebenerText));
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                          TextbreiteExtern => GrafikKonstanten.Nullwert);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                              ViewbreiteExtern => Viewfläche.x);
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                          PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
      Viewfläche := (Textbreite, Textposition.y);
      
   end AnzeigeText;
   
   
   
   procedure AnzeigeJaNein
   is begin
            
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.JaNeinBereich.width, GrafikRecordKonstanten.JaNeinBereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.FragenviewAccesse (ViewKonstanten.Antwort),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.JaNeinBereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
            
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl.AuswahlZwei;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.JaNeinAccessArray'Range loop
         
         Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                                 ViewbreiteExtern => Viewfläche.x);
         
         TextaccessverwaltungssystemGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                  PositionExtern   => Textposition,
                                                                  FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert,
                                                                                                                             AuswahlExtern    => AktuelleAuswahl));
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.JaNeinAccess (TextSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         
         
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
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      -- Das hier dynamisch an die Auswahlmöglichkeiten anpassen? äöü
      -- Ähnliches System wie für die Tippsfläche bauen? äöü
      case
        WelcheAuswahlExtern.StadtEinheit
      is
         when True =>
            Anzeigebereich := GrafikRecordKonstanten.Stadtauswahlbereich;
            
         when False =>
            Anzeigebereich := GrafikRecordKonstanten.Einheitauswahlbereich;
      end case;
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (Anzeigebereich.width, Anzeigebereich.height));
            
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtEinheitviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => Anzeigebereich);
            
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
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
            TextaccessverwaltungssystemGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
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
                                                     str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugStadt)));
                  
               else
                  Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                     str  => To_Wide_Wide_String (Source => Meldungstexte.Zeug (TextnummernKonstanten.ZeugEinheit)));
               end if;
               
            else
               null;
            end if;
                        
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnenGlobaleGrenzen (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                                  ViewbreiteExtern => Viewfläche.x);
            
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                                TextbreiteExtern => Textbreite);
      
            Skalierung.x := TextskalierungGrafik.Breitenskalierung (AktuelleBreiteExtern => Textbreite,
                                                                    ErlaubteBreiteExtern => MaximaleTextbreite);
            Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
            
            if
              Textbreite > MaximaleTextbreite
            then
               Textbreite := MaximaleTextbreite;
               
            else
               null;
            end if;
            
            TextaccessverwaltungssystemGrafik.PositionSkalierenZeichnen (TextaccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                         PositionExtern   => Textposition,
                                                                         SkalierungExtern => Skalierung);
            
            InteraktionAuswahl.PositionenEinheitStadt (AuswahlSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert));
            
            Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                            TextAccessExtern => TextaccessVariablen.AnzeigeEinheitStadtAccess (AuswahlSchleifenwert),
                                                                            ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
         end if;
         
      end loop AuswahlSchleife;
      
      Viewfläche := (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
            
   end AnzeigeEinheitenStadt;

end EingabenanzeigeGrafik;
