with Sf.Graphics.Text;

with Spieltexte;
with GrafikDatentypen;
with TextnummernKonstanten;
with Views;
with TextaccessVariablen;
with InteraktionAuswahl;
with SpeziesDatentypen;
with MenueDatentypen;
with DiplomatieDatentypen;
with TextKonstanten;
with GrafikKonstanten;
with ViewKonstanten;

with LeseDiplomatie;
with LeseGrafiktask;

with AllgemeineViewsGrafik;
with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with MenuestringsSetzenGrafik;
with TextfarbeGrafik;
with Fehlermeldungssystem;
with TextaccessverwaltungssystemGrafik;

package body DiplomatieauswahlGrafik is

   procedure Diplomatieauswahl
     (AuswahlExtern : in Natural)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Spieltexte.Fragen (TextnummernKonstanten.FrageSpeziesDiplomatie)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Hintergrund_Enum,
                                          SpielenamenExtern => False);
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.MenüEinfachbereich.width, GrafikRecordKonstanten.MenüEinfachbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüEinfachbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
                  
      Viewfläche := Textdarstellung (ViewflächeExtern => Viewfläche,
                                      AuswahlExtern    => AuswahlExtern);
      
      
   end Diplomatieauswahl;
   
   
   
   function Textdarstellung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textbreite := GrafikKonstanten.Nullwert;

      PositionenSchleife:
      for PositionSchleifenwert in SpeziesDatentypen.Spezies_Enum'Pos (SpeziesDatentypen.Spezies_Verwendet_Enum'First) .. SpeziesDatentypen.Spezies_Enum'Pos (SpeziesDatentypen.Spezies_Enum'Last) loop
      
         if
           True = InteraktionAuswahl.SpeziesMöglich (SpeziesDatentypen.Spezies_Enum'Val (PositionSchleifenwert))
         then
            Text := To_Unbounded_Wide_Wide_String (Source => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => PositionSchleifenwert + 1,
                                                                                                          WelchesMenüExtern => MenueDatentypen.Spezies_Menü_Enum))
              & TextKonstanten.StandardAbstand;
               
            case
              LeseDiplomatie.AktuellerZustand (SpeziesEinsExtern => LeseGrafiktask.AktiveSpezies,
                                               SpeziesZweiExtern => SpeziesDatentypen.Spezies_Enum'Val (PositionSchleifenwert))
            is
               when DiplomatieDatentypen.Neutral_Enum =>
                  Text := Text & Spieltexte.Zeug (TextnummernKonstanten.ZeugFrieden);
                     
               when DiplomatieDatentypen.Nichtangriffspakt_Enum =>
                  Text := Text & Spieltexte.Zeug (TextnummernKonstanten.ZeugNichtangriffspakt);
               
               when DiplomatieDatentypen.Krieg_Enum =>
                  Text := Text & Spieltexte.Zeug (TextnummernKonstanten.ZeugKrieg);
               
               when DiplomatieDatentypen.Unbekannt_Enum =>
                  Fehlermeldungssystem.Grafik (FehlermeldungExtern => "DiplomatieauswahlGrafik.Textdarstellung: Unbekannter Kontakt");
                  Text := TextKonstanten.LeerUnboundedString;
            end case;
               
            TextaccessverwaltungssystemGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                         TextExtern       => To_Wide_Wide_String (Source => Text),
                                                         FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => PositionSchleifenwert,
                                                                                                                    AuswahlExtern    => AuswahlExtern));
               
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                                    ViewbreiteExtern => ViewflächeExtern.x);
               
            TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                PositionExtern   => Textposition);
               
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                                TextbreiteExtern => Textbreite);
               
            InteraktionAuswahl.PositionenDiplomatieSpezies (SpeziesDatentypen.Spezies_Enum'Val (PositionSchleifenwert)) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.DiplomatieAccess);
               
         else
            null;
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.ZeilenabstandVariabel);

   end Textdarstellung;

end DiplomatieauswahlGrafik;
