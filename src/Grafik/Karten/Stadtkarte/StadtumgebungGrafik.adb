with KartenDatentypen;
with Views;

with LeseStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with ViewsEinstellenGrafik;
with SichtweitenGrafik;
with ObjekteZeichnenGrafik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Viewfläche := (7.00 * SichtweitenGrafik.StadtfelderAbmessung.x, 7.00 * SichtweitenGrafik.StadtfelderAbmessung.y);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.StadtviewAccesse (2),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Stadtbereich (2));
            
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      Viewfläche := (0.00, 0.00);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              KartenWert.EAchse = KartenKonstanten.LeerEAchse
            then
               ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => SichtweitenGrafik.StadtfelderAbmessung,
                                                       PositionExtern  => Viewfläche,
                                                       FarbeExtern     => Sf.Graphics.Color.sfBlack);
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              RasseExtern       => StadtRasseNummerExtern.Rasse)
            then
               null;
               
            else
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                          YKoordinateExtern      => YAchseSchleifenwert,
                                                          XKoordinateExtern      => XAchseSchleifenwert)
               is
                  when True =>
                     FeldBewirtschaftet := True;
               
                  when False =>
                     FeldBewirtschaftet := False;
               end case;
            
               DarstellungUmgebung (KarteKoordinatenExtern => KartenWert,
                                    PositionExtern         => Viewfläche,
                                    StadtRasseNummerExtern => StadtRasseNummerExtern,
                                    BewirtschaftetExtern   => FeldBewirtschaftet);
            end if;
            
            Viewfläche.x := Viewfläche.x + SichtweitenGrafik.StadtfelderAbmessung.x;
            
         end loop XAchseSchleife;
         
         Viewfläche := (0.00, Viewfläche.y + SichtweitenGrafik.StadtfelderAbmessung.y);
         
      end loop YAchseSchleife;
      
   end Stadtumgebung;
   
   
   
   procedure DarstellungUmgebung
     (KarteKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BewirtschaftetExtern : in Boolean)
   is begin
      
      AnzeigeLandschaft (KoordinatenExtern => KarteKoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      case
        LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                 KoordinatenExtern      => KarteKoordinatenExtern)
      is
         when True =>
            if
              BewirtschaftetExtern
            then
               Farbe := Sf.Graphics.Color.sfGreen;
               
            else
               Farbe := Sf.Graphics.Color.sfRed;
            end if;
            
            -- Hier noch eine bessere Lösung bauen, damit die besetzbaren Felder immer zu erkennen sind. äöü
            -- Muss vermutlich Ebenenabhängig sein. äöü
            ObjekteZeichnenGrafik.RahmenZeichnen (PositionExtern    => (PositionExtern.x + 3.00, PositionExtern.y + 3.00),
                                                  FarbeExtern       => Farbe,
                                                  GrößeExtern       => (SichtweitenGrafik.StadtfelderAbmessung.x - 6.00, SichtweitenGrafik.StadtfelderAbmessung.y - 6.00),
                                                  RahmendickeExtern => 3.00);
            
         when False =>
            null;
      end case;
               
   end DarstellungUmgebung;
   
   
   
   procedure AnzeigeLandschaft
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldZeichnen (KoordinatenExtern => KoordinatenExtern,
                          PositionExtern    => PositionExtern);
      
      RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                     PositionExtern    => PositionExtern);
      
      WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   PositionExtern    => PositionExtern);
      
      VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            PositionExtern    => PositionExtern);
      
   end AnzeigeLandschaft;
   
   
   
   procedure KartenfeldZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Gesamtgrund := LeseWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern);
      
      KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.BasisgrundAccess (Gesamtgrund.Basisgrund),
                                                     PositionExtern     => PositionExtern);
        
      case
        Gesamtgrund.Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.ZusatzgrundAccess (Gesamtgrund.Zusatzgrund),
                                                           PositionExtern     => PositionExtern);
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldFluss
      is
         when KartengrundDatentypen.Leer_Fluss_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.KartenflussAccess (KartenfeldFluss),
                                                           PositionExtern     => PositionExtern);
      end case;
      
   end FlussZeichnen;
   
   
      
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldRessource
      is
         when KartengrundDatentypen.Leer_Ressource_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.KartenressourceAccess (KartenfeldRessource),
                                                           PositionExtern     => PositionExtern);
      end case;
      
   end RessourceZeichnen;
   
   
      
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        Wegfeld
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.WegeAccess (Wegfeld),
                                                           PositionExtern     => PositionExtern);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.StadtfeldZeichnen (TexturAccessExtern => EingeleseneTexturenGrafik.VerbesserungenAccess (Verbesserungsfeld),
                                                           PositionExtern     => PositionExtern);
      end case;
      
   end VerbesserungZeichnen;

end StadtumgebungGrafik;
