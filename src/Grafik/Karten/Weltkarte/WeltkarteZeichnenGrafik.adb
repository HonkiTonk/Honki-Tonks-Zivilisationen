with Sf;

with EinheitenKonstanten;
with ZeitKonstanten;
with GrafikKonstanten;
with SpeziesDatentypen;

with LeseEinheitenGebaut;

with EinheitSuchenLogik;
with ObjekteZeichnenGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with SichtweitenGrafik;
with NachGrafiktask;
with EinheitenbewegungsbereichLogik;
with WeltkarteFeldZeichnenGrafik;
with WeltkartZusatzZeichnenGrafik;

package body WeltkarteZeichnenGrafik is
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      WeltkarteFeldZeichnenGrafik.KartenfeldZeichnen (KoordinatenExtern      => KoordinatenExtern,
                                                      PositionExtern         => PositionExtern,
                                                      DurchsichtigkeitExtern => TransparentsExtern);
      
      WeltkarteFeldZeichnenGrafik.FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                 PositionExtern    => PositionExtern);
      
      WeltkarteFeldZeichnenGrafik.RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                     PositionExtern    => PositionExtern);
      
      WeltkartZusatzZeichnenGrafik.WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                   PositionExtern    => PositionExtern);
      
      WeltkartZusatzZeichnenGrafik.VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                            EbeneExtern       => EbeneExtern,
                            PositionExtern    => PositionExtern);
      
      WeltkartZusatzZeichnenGrafik.AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                           PositionExtern    => PositionExtern);
      
      WeltkartZusatzZeichnenGrafik.AnzeigeFeldeffekt (KoordinatenExtern => KoordinatenExtern,
                         PositionExtern    => PositionExtern);
      
      AnzeigeEinheit (KoordinatenExtern          => KoordinatenExtern,
                      EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                      PositionExtern             => PositionExtern);
      
      if
        NachGrafiktask.EinheitBewegungsbereich
        and
          (NachGrafiktask.Einheitenbewegung = False)
        and
          EinheitSpeziesNummerExtern.Nummer /= EinheitenKonstanten.LeerNummer
      then
         AnzeigeBewegungsfeld (KoordinatenExtern        => KoordinatenExtern,
                               PositionExtern           => PositionExtern);
         
      else
         null;
      end if;
      
   end EbeneZeichnen;
   
   
   
   -- Das hier noch einmal überarbeiten. äöü
   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                  LogikGrafikExtern => False);
      
      if
        EinheitSpeziesNummer.Nummer = EinheitenKonstanten.LeerNummer
        and
          EinheitSpeziesNummerExtern.Nummer /= EinheitenKonstanten.LeerNummer
      then
         if
           Clock - StartzeitBlinkintervall > ZeitKonstanten.Blinkintervall
         then
            AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
            StartzeitBlinkintervall := Clock;
            
         else
            null;
         end if;
         
         case
           AusgewählteEinheitAnzeigen
         is
            when False =>
               null;
               
            when True =>
               Einheitenmarkierung (KoordinatenExtern        => KoordinatenExtern,
                                    EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    PositionExtern           => PositionExtern);
         end case;
         
         return;
         
      elsif
        EinheitSpeziesNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return;
         
      elsif
        EinheitSpeziesNummerExtern.Spezies /= EinheitSpeziesNummer.Spezies
      then
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
         
         KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummer.Spezies, FeldeinheitID),
                                                         
                                                         PositionExtern         => PositionExtern,
                                                         DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         return;
         
      else
         null;
      end if;
      
      if
        EinheitSpeziesNummer.Nummer = EinheitSpeziesNummerExtern.Nummer
      then
         null;
         
      elsif
        True = EinheitSuchenLogik.TransporterladungSuchen (TransporterExtern   => EinheitSpeziesNummer,
                                                           LadungsnummerExtern => EinheitSpeziesNummerExtern.Nummer)
      then
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
         case
           FeldeinheitID
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummer.Spezies, FeldeinheitID),
                                                               PositionExtern         => PositionExtern,
                                                               DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         end case;
         
      else
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
         case
           FeldeinheitID
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummer.Spezies, FeldeinheitID),
                                                               PositionExtern         => PositionExtern,
                                                               DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         end case;
         
         return;
      end if;
      
      if
        Clock - StartzeitBlinkintervall > ZeitKonstanten.Blinkintervall
      then
         AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
         StartzeitBlinkintervall := Clock;
            
      else
         null;
      end if;
      
      if
        AusgewählteEinheitAnzeigen = False
        and
          NachGrafiktask.Einheitenbewegung = False
      then
         return;
               
      else
         AusgewählteEinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
      case
        AusgewählteEinheitID
      is
         when EinheitenKonstanten.LeerID =>
            return;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccess (EinheitSpeziesNummerExtern.Spezies, AusgewählteEinheitID),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
            
   end AnzeigeEinheit;
   
   
   
   -- Anstelle des Rahmens später vielleicht eine bessere Markierung ausdenken? äöü
   procedure Einheitenmarkierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        KoordinatenExtern.EAchse /= EinheitKoordinaten.EAchse
        and
          KoordinatenExtern.YAchse = EinheitKoordinaten.YAchse
          and
            KoordinatenExtern.XAchse = EinheitKoordinaten.XAchse
      then
         RahmenSchleife:
         for RahmenSchleifenwert in UmgebungArray'Range loop
            
            WeltkartZusatzZeichnenGrafik.RahmenZeichnen (WelcheRichtungExtern => RahmenSchleifenwert,
                                                         PositionExtern       => PositionExtern,
                                                         SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies);
            
         end loop RahmenSchleife;
         
      else
         null;
      end if;
      
   end Einheitenmarkierung;
   
   
   
   procedure AnzeigeBewegungsfeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      case
        EinheitenbewegungsbereichLogik.Bewegungsbereich (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse)
      is
         when False =>
            null;
            
         when True =>
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => SichtweitenGrafik.KartenfelderAbmessung,
                                                    PositionExtern  => PositionExtern,
                                                    FarbeExtern     => (255, 255, 255, GrafikKonstanten.Bewegungsfeldtransparents));
      end case;
        
   end AnzeigeBewegungsfeld;

end WeltkarteZeichnenGrafik;
