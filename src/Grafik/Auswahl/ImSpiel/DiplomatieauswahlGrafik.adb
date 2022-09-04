pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with Meldungstexte;
with GrafikDatentypen;
with TextnummernKonstanten;
with Views;
with TextaccessVariablen;
with InteraktionAuswahl;
with RassenDatentypen;
with MenueDatentypen;
with DiplomatieDatentypen;
with SpielVariablen;
with TextKonstanten;

with AllgemeineViewsGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with MenuestringsSetzenGrafik;
with TexteinstellungenGrafik;
with NachGrafiktask;
with Fehler;

package body DiplomatieauswahlGrafik is

   procedure Diplomatieauswahl
     (AuswahlExtern : in Natural)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Meldungstexte.Frage (TextnummernKonstanten.FrageRasseDiplomatie)),
                                        HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum);
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.MenüEinfachbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                        AbmessungenExtern => Viewfläche);
                  
      Viewfläche := Textdarstellung (ViewflächeExtern => Viewfläche,
                                      AuswahlExtern    => AuswahlExtern);
      
      
   end Diplomatieauswahl;
   
   
   
   -- Hier auch gleich noch eine Anzeige für die Meinung und den aktuellen Zustand einbauen? äöü
   function Textdarstellung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textbreite := 0.00;

      PositionenSchleife:
      for PositionSchleifenwert in RassenDatentypen.Rassen_Enum'Pos (RassenDatentypen.Rassen_Verwendet_Enum'First) .. RassenDatentypen.Rassen_Enum'Pos (RassenDatentypen.Rassen_Enum'Last) loop
      
         case
           InteraktionAuswahl.RassenMöglich (RassenDatentypen.Rassen_Enum'Val (PositionSchleifenwert))
         is
            when True =>
               if
                 PositionSchleifenwert = AuswahlExtern
               then
                  Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
                     
               else
                  Farbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
               end if;
               
               Sf.Graphics.Text.setColor (text  => TextaccessVariablen.TextAccess,
                                          color => Farbe);
               
               Text := To_Unbounded_Wide_Wide_String (Source => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => PositionSchleifenwert + 1,
                                                                                                             WelchesMenüExtern => MenueDatentypen.Rassen_Menü_Enum))
                 & TextKonstanten.StandardAbstand;
               
               case
                 SpielVariablen.Diplomatie (NachGrafiktask.AktuelleRasse, RassenDatentypen.Rassen_Enum'Val (PositionSchleifenwert)).AktuellerZustand
               is
                  when DiplomatieDatentypen.Neutral_Enum =>
                     Text := Text & Meldungstexte.Zeug (TextnummernKonstanten.ZeugFrieden);
                     
                  when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
                     Text := Text & Meldungstexte.Zeug (TextnummernKonstanten.ZeugNichtangriffspakt);
               
                  when DiplomatieDatentypen.Krieg_Enum =>
                     Text := Text & Meldungstexte.Zeug (TextnummernKonstanten.ZeugKrieg);
               
                  when DiplomatieDatentypen.Unbekannt_Enum =>
                     Fehler.GrafikFehler (FehlermeldungExtern => "DiplomatieauswahlGrafik.Textdarstellung - Kontakt ist unbekannt.");
               end case;

               Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                                  str  => To_Wide_Wide_String (Source => Text));
               
               Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                                     ViewbreiteExtern => ViewflächeExtern.x);
               
               Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                             position => Textposition);

               Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                                 TextbreiteExtern => Textbreite);
               
               InteraktionAuswahl.PositionenDiplomatieRasse (RassenDatentypen.Rassen_Enum'Val (PositionSchleifenwert)) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.TextAccess);
               
               Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                                  text         => TextaccessVariablen.TextAccess);

            when False =>
               null;
         end case;
         
         Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y);

   end Textdarstellung;

end DiplomatieauswahlGrafik;
