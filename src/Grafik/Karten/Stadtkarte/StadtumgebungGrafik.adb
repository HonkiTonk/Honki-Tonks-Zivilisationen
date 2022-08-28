pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with KartenVerbesserungDatentypen; use KartenVerbesserungDatentypen;
with KartenKonstanten;
with Views;

with LeseStadtGebaut;
with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with ViewsEinstellenSFML;
with BerechnungenKarteSFML;
with ObjekteZeichnenSFML;
with KartenspritesZeichnenSFML;
with EingeleseneTexturenSFML;
with FarbgebungSFML;

package body StadtumgebungGrafik is

   procedure Stadtumgebung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      Viewfläche := (7.00 * BerechnungenKarteSFML.StadtfelderAbmessung.x, 7.00 * BerechnungenKarteSFML.StadtfelderAbmessung.y);
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.StadtumgebungviewAccess,
                                          GrößeExtern          => Viewfläche,
                                          AnzeigebereichExtern => GrafikRecordKonstanten.StadtumgebungBereich);
            
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      Viewfläche := (0.00, 0.00);
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            if
              KartenWert.EAchse = KartenKonstanten.LeerEAchse
            then
               ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                     PositionExtern       => Viewfläche,
                                                     FarbeExtern          => Sf.Graphics.Color.sfBlack);
               
            elsif
              False = LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                           RasseExtern       => StadtRasseNummerExtern.Rasse)
            then
               ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                     PositionExtern       => Viewfläche,
                                                     FarbeExtern          => Sf.Graphics.Color.sfBlack);
               
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
            
            Viewfläche.x := Viewfläche.x + BerechnungenKarteSFML.StadtfelderAbmessung.x;
            
         end loop XAchseSchleife;
         
         Viewfläche.x := 0.00;
         Viewfläche.y := Viewfläche.y + BerechnungenKarteSFML.StadtfelderAbmessung.y;
         
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
        LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              KoordinatenExtern      => KarteKoordinatenExtern)
      is
         when True =>
            if
              BewirtschaftetExtern
            then
               Farbe := Sf.Graphics.Color.sfGreen;
               
            else
               Farbe := Sf.Graphics.Color.sfBlack;
            end if;
            
            ObjekteZeichnenSFML.RahmenZeichnen (PositionExtern    => (PositionExtern.x + 3.00, PositionExtern.y + 3.00),
                                                FarbeExtern       => Farbe,
                                                GrößeExtern       => (BerechnungenKarteSFML.StadtfelderAbmessung.x - 6.00, BerechnungenKarteSFML.StadtfelderAbmessung.y - 6.00),
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
      
      Kartenfeld := LeseKarten.AktuellerGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenSFML.KartenfelderAccess (Kartenfeld),
                                                             PositionExtern     => PositionExtern)
      is
         when True =>
            null;
            
         when False =>
            ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => BerechnungenKarteSFML.StadtfelderAbmessung,
                                                  PositionExtern       => PositionExtern,
                                                  FarbeExtern          => FarbgebungSFML.FarbeKartenfeldErmitteln (GrundExtern => Kartenfeld));
      end case;
      
   end KartenfeldZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseKarten.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldFluss = KartengrundDatentypen.Leer_Fluss_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenSFML.KartenflussAccess (KartenfeldFluss),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 5.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.40 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfBlue);
      end if;
      
   end FlussZeichnen;
   
   
      
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseKarten.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      if
        KartenfeldRessource = KartengrundDatentypen.Leer_Ressource_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenSFML.KartenressourceAccess (KartenfeldRessource),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
         
      else
         ObjekteZeichnenSFML.KreisZeichnen (RadiusExtern      => BerechnungenKarteSFML.StadtfelderAbmessung.x / 3.00,
                                            PositionExtern    => PositionExtern,
                                            FarbeExtern       => Sf.Graphics.Color.sfBlack);
      end if;
      
   end RessourceZeichnen;
   
   
      
   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseKarten.Weg (KoordinatenExtern => KoordinatenExtern);
      
      if
        Wegfeld = KartenVerbesserungDatentypen.Leer_Weg_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenSFML.WegeAccess (Wegfeld),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                               PositionExtern       => (PositionExtern.x, PositionExtern.y + 0.80 * BerechnungenKarteSFML.StadtfelderAbmessung.y),
                                               FarbeExtern          => Sf.Graphics.Color.sfRed);
      end if;
   
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Verbesserungsfeld := LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      if
        Verbesserungsfeld = KartenVerbesserungDatentypen.Leer_Verbesserung_Enum
      then
         null;
         
      elsif
        True = KartenspritesZeichnenSFML.SpriteGezeichnetStadtfeld (TexturAccessExtern => EingeleseneTexturenSFML.VerbesserungenAccess (Verbesserungsfeld),
                                                                    PositionExtern     => PositionExtern)
      then
         null;
            
      else
         ObjekteZeichnenSFML.RechteckZeichnen (AbmessungExtern      => (BerechnungenKarteSFML.StadtfelderAbmessung.x / 2.00, BerechnungenKarteSFML.StadtfelderAbmessung.y / 2.00),
                                               PositionExtern       => PositionExtern,
                                               FarbeExtern          => Sf.Graphics.Color.sfCyan);
      end if;
      
   end VerbesserungZeichnen;

end StadtumgebungGrafik;
