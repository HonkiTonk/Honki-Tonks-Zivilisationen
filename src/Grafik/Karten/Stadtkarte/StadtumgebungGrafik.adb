
with Sf.Graphics.Text;

with KartenDatentypen;
with Views;
with KartengrundDatentypen;
with ViewKonstanten;
with TextaccessVariablen;
with Spieltexte;
with SpeziesKonstanten;
with GrafikKonstanten;
with TextnummernKonstanten;
with ProduktionDatentypen;
with SystemDatentypen;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with ViewsEinstellenGrafik;
with ObjekteZeichnenGrafik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with FeldproduktionLogik;
with TexturenfelderVariablenGrafik;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtauswahlExtern : in StadtGrafikRecords.StadtumgebungGrafikRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => Viewfläche,
                                                                        VerhältnisExtern => (GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung).width,
                                                                                              GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (ViewKonstanten.StadtUmgebung),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (ViewKonstanten.StadtUmgebung));
      
      Feldgröße.x := Viewfläche.x / GrafikKonstanten.AnzahlStadtumgebungsfelder;
      Feldgröße.y := Viewfläche.y / GrafikKonstanten.AnzahlStadtumgebungsfelder;
      
      AktuellePosition := GrafikRecordKonstanten.Nullposition;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.SenkrechteUmgebungDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.WaagerechteUmgebungDrei'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtauswahlExtern.Koordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              KartenWert.EAchse = KartenKonstanten.LeerEAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              SpeziesExtern     => StadtauswahlExtern.SpeziesNummer.Spezies)
            then
               null;
               
            else
               case
                 StadtauswahlExtern.UmgebungBewirtschaftung (YAchseSchleifenwert, XAchseSchleifenwert)
               is
                  when True =>
                     FeldBewirtschaftet := True;
               
                  when False =>
                     FeldBewirtschaftet := False;
               end case;
            
               DarstellungUmgebung (KarteKoordinatenExtern   => KartenWert,
                                    PositionExtern           => AktuellePosition,
                                    FeldgrößeExtern          => Feldgröße,
                                    StadtSpeziesNummerExtern => StadtauswahlExtern.SpeziesNummer,
                                    BewirtschaftetExtern     => FeldBewirtschaftet);
            end if;
            
            AktuellePosition.x := AktuellePosition.x + Feldgröße.x;
            
         end loop XAchseSchleife;
         
         AktuellePosition := (GrafikRecordKonstanten.Nullposition.x, AktuellePosition.y + Feldgröße.y);
         
      end loop YAchseSchleife;
      
   end Stadtumgebung;
   
   
   
   procedure DarstellungUmgebung
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      BewirtschaftetExtern : in Boolean)
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                         FeldgrößeExtern   => FeldgrößeExtern,
                         PositionExtern    => PositionExtern);
      
      Grundbelegung := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KarteKoordinatenExtern);
      Rahmendicke := (FeldgrößeExtern.y / 20.00 + FeldgrößeExtern.x / 20.00) / GrafikKonstanten.Halbierung;
      
      if
        Grundbelegung.Spezies = SpeziesKonstanten.LeerSpezies
      then
         return;
        
      elsif
        Grundbelegung = StadtSpeziesNummerExtern
      then
         case
           BewirtschaftetExtern
         is
            when True =>
               Farbe := Sf.Graphics.Color.sfGreen;
               Wirtschaftsinformationen (KoordinatenExtern => KarteKoordinatenExtern,
                                         PositionExtern    => (PositionExtern.x + Rahmendicke, PositionExtern.y + Rahmendicke),
                                         FeldgrößeExtern   => (FeldgrößeExtern.x - 2.80 * Rahmendicke, FeldgrößeExtern.y - GrafikKonstanten.Verdoppelung * Rahmendicke),
                                         SpeziesExtern     => StadtSpeziesNummerExtern.Spezies);
               
            when False =>
               Farbe := Sf.Graphics.Color.sfBlue;
         end case;
            
      elsif
        Grundbelegung.Spezies = StadtSpeziesNummerExtern.Spezies
      then
         Farbe := Sf.Graphics.Color.sfCyan;
         
      else
         Farbe := Sf.Graphics.Color.sfRed;
      end if;
            
      ObjekteZeichnenGrafik.RahmenZeichnen (PositionExtern    => (PositionExtern.x + Rahmendicke, PositionExtern.y + Rahmendicke),
                                            FarbeExtern       => Farbe,
                                            GrößeExtern       => (FeldgrößeExtern.x - GrafikKonstanten.Verdoppelung * Rahmendicke, FeldgrößeExtern.y - GrafikKonstanten.Verdoppelung * Rahmendicke),
                                            RahmendickeExtern => Rahmendicke);
      
   end DarstellungUmgebung;
   
   
   
   procedure Wirtschaftsinformationen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      ProduktionSchleife:
      for ProduktionSchleifenwert in ProduktionDatentypen.Produktion_Enum'Range loop
         
         case
           ProduktionSchleifenwert
         is
            when ProduktionDatentypen.Nahrung_Enum =>
               Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugNahrungsmittel) & FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                                                                                           SpeziesExtern        => SpeziesExtern,
                                                                                                                           ProduktionsartExtern => ProduktionSchleifenwert)'Wide_Wide_Image;
               
            when ProduktionDatentypen.Material_Enum =>
               Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugRessourcenproduktion) & FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                                                                                                 SpeziesExtern        => SpeziesExtern,
                                                                                                                                 ProduktionsartExtern => ProduktionSchleifenwert)'Wide_Wide_Image;
               
            when ProduktionDatentypen.Geld_Enum =>
               Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugGeldproduktion) & FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                                                                                           SpeziesExtern        => SpeziesExtern,
                                                                                                                           ProduktionsartExtern => ProduktionSchleifenwert)'Wide_Wide_Image;
               
            when ProduktionDatentypen.Forschung_Enum =>
               Text := Spieltexte.Zeug (TextnummernKonstanten.ZeugWissensproduktion) & FeldproduktionLogik.Feldproduktion (KoordinatenExtern    => KoordinatenExtern,
                                                                                                                              SpeziesExtern        => SpeziesExtern,
                                                                                                                              ProduktionsartExtern => ProduktionSchleifenwert)'Wide_Wide_Image;
         end case;
         
         TextaccessverwaltungssystemEinfachGrafik.TextPosition (TextaccessExtern => TextaccessVariablen.StadtumgebungAccess,
                                                         TextExtern       => To_Wide_Wide_String (Source => Text),
                                                         PositionExtern   => (PositionExtern.x, (FeldgrößeExtern.y / Schriftabstandanpassung)
                                                                              * Float (ProduktionDatentypen.Produktion_Enum'Pos (ProduktionSchleifenwert)) + PositionExtern.y));
         
         if
           Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtumgebungAccess).width > FeldgrößeExtern.x
         then
            Skalierung.x := FeldgrößeExtern.x / Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtumgebungAccess).width;
            
         else
            Skalierung.x := GrafikKonstanten.Einswert;
         end if;
         
         if
           Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtumgebungAccess).height * Schriftabstandanpassung > FeldgrößeExtern.y
         then
            Skalierung.y := FeldgrößeExtern.y / (Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.StadtumgebungAccess).height * Schriftabstandanpassung);
            
         else
            Skalierung.y := GrafikKonstanten.Einswert;
         end if;
         
         TextaccessverwaltungssystemEinfachGrafik.SkalierenZeichnen (TextaccessExtern => TextaccessVariablen.StadtumgebungAccess,
                                                              SkalierungExtern => Skalierung);
                  
      end loop ProduktionSchleife;
      
   end Wirtschaftsinformationen;
   
   
   
   -- Hier auch noch Einheiten zeichnen lassen? äöü
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldZeichnen (KoordinatenExtern => KoordinatenExtern,
                          FeldgrößeExtern   => FeldgrößeExtern,
                          PositionExtern    => PositionExtern);
      
      FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                     FeldgrößeExtern   => FeldgrößeExtern,
                     PositionExtern    => PositionExtern);
      
      RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                         FeldgrößeExtern   => FeldgrößeExtern,
                         PositionExtern    => PositionExtern);
      
      WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   FeldgrößeExtern   => FeldgrößeExtern,
                   PositionExtern    => PositionExtern);
      
      VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            FeldgrößeExtern   => FeldgrößeExtern,
                            PositionExtern    => PositionExtern);
      
      FeldeffektZeichnen (KoordinatenExtern => KoordinatenExtern,
                          FeldgrößeExtern   => FeldgrößeExtern,
                          PositionExtern    => PositionExtern);
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern  => EingeleseneTexturenGrafik.BasisgrundAccess,
                                                                TexturbereichExtern => TexturenfelderVariablenGrafik.BasisgrundRechteck (BasisgrundExtern => Gesamtgrund.Basisgrund),
                                                                FeldgrößeExtern     => FeldgrößeExtern,
                                                                PositionExtern      => PositionExtern);
        
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern  => EingeleseneTexturenGrafik.ZusatzgrundAccess,
                                                                      TexturbereichExtern => TexturenfelderVariablenGrafik.ZusatzgrundRechteck (ZusatzgrundExtern => Gesamtgrund.Zusatzgrund),
                                                                      FeldgrößeExtern     => FeldgrößeExtern,
                                                                      PositionExtern      => PositionExtern);
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldFluss
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern  => EingeleseneTexturenGrafik.FlussAccess,
                                                                      TexturbereichExtern => TexturenfelderVariablenGrafik.FlussRechteck (FlussExtern => KartenfeldFluss),
                                                                      FeldgrößeExtern     => FeldgrößeExtern,
                                                                      PositionExtern      => PositionExtern);
      end case;
      
   end FlussZeichnen;
   
   
      
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldRessource
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern  => EingeleseneTexturenGrafik.RessourcenAccess,
                                                                      TexturbereichExtern => TexturenfelderVariablenGrafik.RessourcenRechteck (RessourceExtern => KartenfeldRessource),
                                                                      FeldgrößeExtern     => FeldgrößeExtern,
                                                                      PositionExtern      => PositionExtern);
      end case;
      
   end RessourceZeichnen;
   
   
      
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        Wegfeld
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern  => EingeleseneTexturenGrafik.WegeAccess,
                                                                      TexturbereichExtern => TexturenfelderVariablenGrafik.WegeRechteck (WegExtern => Wegfeld),
                                                                      FeldgrößeExtern     => FeldgrößeExtern,
                                                                      PositionExtern      => PositionExtern);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern  => EingeleseneTexturenGrafik.VerbesserungenAccess,
                                                                      TexturbereichExtern => TexturenfelderVariablenGrafik.VerbesserungRechteck (VerbesserungExtern => Verbesserungsfeld),
                                                                      FeldgrößeExtern     => FeldgrößeExtern,
                                                                      PositionExtern      => PositionExtern);
      end case;
      
   end VerbesserungZeichnen;
   
   
   
   procedure FeldeffektZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EffekteSchleife:
      for EffektSchleifenwert in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum'Range loop
         
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                 WelcherEffektExtern => EffektSchleifenwert)
         is
            when True =>
               KartenspritesZeichnenGrafik.StadtbewirtschaftungZeichnen (TexturAccessExtern  => EingeleseneTexturenGrafik.FeldeffekteAccess,
                                                                         TexturbereichExtern => TexturenfelderVariablenGrafik.FeldeffekteRechteck (FeldeffektedExtern => EffektSchleifenwert),
                                                                         FeldgrößeExtern     => FeldgrößeExtern,
                                                                         PositionExtern      => PositionExtern);
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
   end FeldeffektZeichnen;

end StadtumgebungGrafik;
