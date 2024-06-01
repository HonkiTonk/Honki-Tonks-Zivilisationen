with ZeitKonstanten;
with GrafikKonstanten;
with EinheitenKonstanten;
with KartenartDatentypen;
with SystemDatentypen;

with LeseEinheitenGebaut;
with LeseGrafiktask;

with EinheitSuchenLogik;
with ObjekteZeichnenGrafik;
with EingeleseneTexturenGrafik;
with KartenspritesZeichnenGrafik;
with SichtweitenGrafik;
with EinheitenbewegungsbereichLogik;
with WeltkarteZusatzZeichnenGrafik;
with TexturenfelderVariablenGrafik;

package body WeltkarteEinheitZeichnenGrafik is

   procedure AnzeigeEinheit
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type EinheitenDatentypen.EinheitenID;
   begin
      
      EinheitSpeziesNummer := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
      
      if
        EinheitSpeziesNummer.Nummer = EinheitenKonstanten.LeerNummer
        and
          EinheitenauswahlExtern.SpeziesNummer.Nummer /= EinheitenKonstanten.LeerNummer
      then
         case
           EinheitAnzeigen
         is
            when False =>
               null;
               
            when True =>
               Einheitenmarkierung (KoordinatenExtern      => KoordinatenExtern,
                                    EinheitenauswahlExtern => EinheitenauswahlExtern,
                                    PositionExtern         => PositionExtern);
         end case;
         
         return;
         
      elsif
        EinheitSpeziesNummer.Nummer = EinheitenKonstanten.LeerNummer
      then
         return;
         
      elsif
        EinheitenauswahlExtern.SpeziesNummer.Spezies /= EinheitSpeziesNummer.Spezies
      then
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
         
         KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccessGesamt (EinheitSpeziesNummer.Spezies),
                                                            TexturbereichExtern    => TexturenfelderVariablenGrafik.Einheitenbereich (EinheitExtern => FeldeinheitID,
                                                                                                                                      SpeziesExtern => EinheitSpeziesNummer.Spezies),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         return;
         
      elsif
        EinheitSpeziesNummer.Nummer = EinheitenauswahlExtern.SpeziesNummer.Nummer
      then
         null;
         
      else
         FeldeinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummer);
      
         case
           FeldeinheitID
         is
            when EinheitenKonstanten.LeerID =>
               null;
            
            when others =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccessGesamt (EinheitSpeziesNummer.Spezies),
                                                                  TexturbereichExtern    => TexturenfelderVariablenGrafik.Einheitenbereich (EinheitExtern => FeldeinheitID,
                                                                                                                                            SpeziesExtern => EinheitSpeziesNummer.Spezies),
                                                                  PositionExtern         => PositionExtern,
                                                                  DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         end case;
         
         case
           EinheitSuchenLogik.TransporterladungSuchen (TransporterExtern   => EinheitSpeziesNummer,
                                                       LadungsnummerExtern => EinheitenauswahlExtern.SpeziesNummer.Nummer)
         is
            when False =>
               return;
               
            when True =>
               null;
         end case;
      end if;
      
      if
        EinheitAnzeigen = False
        and
          LeseGrafiktask.Einheitenbewegung = False
      then
         null;
         
      elsif
        EinheitenauswahlExtern.ID = EinheitenKonstanten.LeerID
      then
         null;
         
      else
         KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.EinheitenAccessGesamt (EinheitenauswahlExtern.SpeziesNummer.Spezies),
                                                            TexturbereichExtern    => TexturenfelderVariablenGrafik.Einheitenbereich (EinheitExtern => EinheitenauswahlExtern.ID,
                                                                                                                                      SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end if;
      
   end AnzeigeEinheit;
   
   
   
   -- Anstelle des Rahmens später vielleicht eine bessere Markierung ausdenken? äöü
   procedure Einheitenmarkierung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.EbeneVorhanden;
   begin
      
      if
        KoordinatenExtern.EAchse /= EinheitenauswahlExtern.Koordinaten.EAchse
        and
          KoordinatenExtern.YAchse = EinheitenauswahlExtern.Koordinaten.YAchse
          and
            KoordinatenExtern.XAchse = EinheitenauswahlExtern.Koordinaten.XAchse
      then
         RahmenSchleife:
         for RahmenSchleifenwert in KartenartDatentypen.Himmelsrichtungen_Enum'Range loop
            
            WeltkarteZusatzZeichnenGrafik.RahmenZeichnen (WelcheRichtungExtern => RahmenSchleifenwert,
                                                          PositionExtern       => PositionExtern,
                                                          SpeziesExtern        => EinheitenauswahlExtern.SpeziesNummer.Spezies);
            
         end loop RahmenSchleife;
         
      else
         null;
      end if;
      
   end Einheitenmarkierung;
   
   
   
   function EinheitAnzeigen
     return Boolean
   is begin
      
      if
        Clock - StartzeitBlinkintervall > ZeitKonstanten.Blinkintervall
      then
         AusgewählteEinheitAnzeigen := not AusgewählteEinheitAnzeigen;
         StartzeitBlinkintervall := Clock;
            
      else
         null;
      end if;
      
      return AusgewählteEinheitAnzeigen;
      
   end EinheitAnzeigen;
   
   
   
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
            ObjekteZeichnenGrafik.RechteckZeichnen (AbmessungExtern => SichtweitenGrafik.Kartenfeldfläche,
                                                    PositionExtern  => PositionExtern,
                                                    FarbeExtern     => (255, 255, 255, GrafikKonstanten.Bewegungsfeldtransparents));
      end case;
        
   end AnzeigeBewegungsfeld;

end WeltkarteEinheitZeichnenGrafik;
