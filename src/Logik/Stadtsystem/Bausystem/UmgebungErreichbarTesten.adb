pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with BewegungPassierbarkeitPruefen;
with EinheitSuchen;

package body UmgebungErreichbarTesten is
   
   function UmgebungErreichbarTesten
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.MinimimMaximumID;
      NotwendigeFelderExtern : in Positive)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      GefundeneFelder := 1;
      Umgebung := 1;
      BereitsGetestet := Umgebung - 1;
      
      BereichSchleife:
      loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in -Umgebung .. Umgebung loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in -Umgebung .. Umgebung loop
               
               KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                    ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                    LogikGrafikExtern => True);
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               elsif
                 (YÄnderungSchleifenwert = 0
                  and
                    XÄnderungSchleifenwert = 0)
                 or
                   (BereitsGetestet >= abs (YÄnderungSchleifenwert)
                    and
                      BereitsGetestet >= abs (XÄnderungSchleifenwert))
               then
                  null;
                  
               elsif
                 LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                           KoordinatenExtern => KartenWert)
                 = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = EinheitenKonstanten.LeerNummer
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                          IDExtern              => IDExtern,
                                                                          NeueKoordinatenExtern => KartenWert)
                 = True
                 and
                   NochErreichbar (AktuelleKoordinatenExtern => KartenWert,
                                   RasseExtern               => RasseExtern,
                                   IDExtern                  => IDExtern)
                 = True
                 and
                   GefundeneFelder < NotwendigeFelderExtern
               then
                  GefundeneFelder := GefundeneFelder + 1;
                  
               elsif
                 LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                           KoordinatenExtern => KartenWert)
                 = True
                 and
                   EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer = EinheitenKonstanten.LeerNummer
                 and
                   BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                          IDExtern              => IDExtern,
                                                                          NeueKoordinatenExtern => KartenWert)
                 = True
                 and
                   NochErreichbar (AktuelleKoordinatenExtern => KartenWert,
                                   RasseExtern               => RasseExtern,
                                   IDExtern                  => IDExtern)
                 = True
               then
                  return KartenWert;
                              
               else
                  null;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
            
         exit BereichSchleife when Umgebung = KartenDatentypen.UmgebungsbereichDrei'Last;
         
         Umgebung := Umgebung + 1;
         BereitsGetestet := Umgebung - 1;
                     
      end loop BereichSchleife;
      
      return KartenRecordKonstanten.LeerKartenKoordinaten;
      
   end UmgebungErreichbarTesten;
   
   
   
   function NochErreichbar
     (AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitStadtDatentypen.MinimimMaximumID)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWertZwei := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                     ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                     LogikGrafikExtern => True);
            
            if
              KartenWertZwei.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                                        KoordinatenExtern => KartenWertZwei)
              = True
              and
                BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                       IDExtern              => IDExtern,
                                                                       NeueKoordinatenExtern => KartenWertZwei)
              = True
            then
               return True;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
        
   end NochErreichbar;

end UmgebungErreichbarTesten;