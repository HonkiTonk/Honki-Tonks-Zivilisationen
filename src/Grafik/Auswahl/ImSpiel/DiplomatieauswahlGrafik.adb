with Sf.Graphics.Text;

with TextKonstantenHTSEB;
with MeldungssystemHTSEB;

with Spieltexte;
with GrafikDatentypen;
with TextnummernKonstanten;
with Views;
with TextaccessVariablen;
with InteraktionAuswahl;
with SpeziesDatentypen;
with MenueDatentypen;
with DiplomatieDatentypen;
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
with TextaccessverwaltungssystemEinfachGrafik;

package body DiplomatieauswahlGrafik is

   procedure Diplomatieauswahl
     (AuswahlExtern : in Natural)
   is begin
      
      AllgemeineViewsGrafik.Überschrift (ÜberschriftExtern => To_Wide_Wide_String (Source => Spieltexte.Fragen (TextnummernKonstanten.FrageSpeziesDiplomatie)),
                                          HintergrundExtern => GrafikDatentypen.Bauen_Enum,
                                          SpielenamenExtern => False);
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.MenüEinfachbereich.width, GrafikRecordKonstanten.MenüEinfachbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.MenüEinfachbereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => Viewfläche);
                  
      Viewfläche := Textdarstellung (ViewflächeExtern => Viewfläche,
                                      AuswahlExtern    => AuswahlExtern);
      
      
   end Diplomatieauswahl;
   
   
   
   function Textdarstellung
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f;
      AuswahlExtern : in Natural)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textbreite := GrafikKonstanten.Nullwert;

      PositionenSchleife:
      for PositionSchleifenwert in SpeziesDatentypen.Spezies_Enum'Pos (SpeziesDatentypen.Spezies_Vorhanden_Enum'First) .. SpeziesDatentypen.Spezies_Enum'Pos (SpeziesDatentypen.Spezies_Enum'Last) loop
      
         if
           True = InteraktionAuswahl.SpeziesMöglich (SpeziesDatentypen.Spezies_Enum'Val (PositionSchleifenwert))
         then
            Text := To_Unbounded_Wide_Wide_String (Source => MenuestringsSetzenGrafik.MenüstringsSetzen (WelcheZeileExtern => PositionSchleifenwert + 1,
                                                                                                          WelchesMenüExtern => MenueDatentypen.Spezies_Menü_Enum))
              & TextKonstantenHTSEB.StandardAbstand;
               
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
                  MeldungssystemHTSEB.Grafik (MeldungExtern => "DiplomatieauswahlGrafik.Textdarstellung: Unbekannter Kontakt");
                  Text := TextKonstantenHTSEB.LeerUnboundedString;
            end case;
               
            TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                TextExtern       => To_Wide_Wide_String (Source => Text),
                                                                FarbeExtern      => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => PositionSchleifenwert,
                                                                                                                           AuswahlExtern    => AuswahlExtern));
               
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                                    ViewbreiteExtern => ViewflächeExtern.x);
               
            TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                       PositionExtern   => Textposition);
               
            Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.DiplomatieAccess,
                                                                                TextbreiteExtern => Textbreite);
               
            InteraktionAuswahl.PositionenDiplomatieSpezies (SpeziesDatentypen.Spezies_Enum'Val (PositionSchleifenwert)) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.DiplomatieAccess);
               
         else
            null;
         end if;
         
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
         
      end loop PositionenSchleife;

      return (Textbreite, Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand);

   end Textdarstellung;

end DiplomatieauswahlGrafik;
