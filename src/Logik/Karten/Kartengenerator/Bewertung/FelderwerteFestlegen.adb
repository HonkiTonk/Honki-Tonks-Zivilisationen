pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartengrundDatentypen;
with KartenVerbesserungDatentypen;

with SchreibeKarten;
with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with KartenAllgemein;

package body FelderwerteFestlegen is
   
   procedure EinzelnesKartenfeldBewerten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
            
      YAchseÄnderungSchleife:
      for YAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseÄnderungSchleife:
         for XAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
                  
            KartenWertEins (KoordinatenExtern.EAchse) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                ÄnderungExtern    => (0, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert),
                                                                                                                                LogikGrafikExtern => True);
            
            case
              KartenWertEins (KoordinatenExtern.EAchse).XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                     
               when others =>
                  KartenfeldBewerten (KoordinatenExtern => KartenWertEins (KoordinatenExtern.EAchse),
                                      RasseExtern       => EinheitenKonstanten.LeerRasse);
            end case;
            
         end loop XAchseÄnderungSchleife;
      end loop YAchseÄnderungSchleife;
      
   end EinzelnesKartenfeldBewerten;
   


   procedure KartenfeldBewerten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      Gesamtbewertung := (others => (others => KartenKonstanten.LeerBewertung));
      
      BewertungYÄnderungSchleife:
      for BewertungYÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         BewertungXÄnderungSchleife:
         for BewertungXÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWertZwei (KoordinatenExtern.EAchse) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                ÄnderungExtern    => (0, BewertungYÄnderungSchleifenwert, BewertungXÄnderungSchleifenwert),
                                                                                                                                LogikGrafikExtern => True);

            case
              KartenWertZwei (KoordinatenExtern.EAchse).XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  if
                    BewertungYÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range
                    and
                      BewertungXÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range
                  then
                     Teiler (KoordinatenExtern.EAchse) := 1;
                     
                  elsif
                    BewertungYÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichZwei'Range
                    and
                      BewertungXÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichZwei'Range
                  then
                     Teiler (KoordinatenExtern.EAchse) := 2;
                        
                  else
                     Teiler (KoordinatenExtern.EAchse) := 3;
                  end if;
                  
                  BewertungSelbst (KoordinatenFeldExtern     => KoordinatenExtern,
                                   KoordinatenUmgebungExtern => KartenWertZwei (KoordinatenExtern.EAchse),
                                   RasseExtern               => RasseExtern,
                                   TeilerExtern              => Teiler (KoordinatenExtern.EAchse));
            end case;
                                 
         end loop BewertungXÄnderungSchleife;
      end loop BewertungYÄnderungSchleife;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           SpielVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.KI_Spieler_Enum
           and
             (RasseExtern = EinheitenKonstanten.LeerRasse
              or
                RasseExtern = RasseSchleifenwert)
         then
            SchreibeKarten.Bewertung (KoordinatenExtern  => KoordinatenExtern,
                                      RasseExtern        => RasseSchleifenwert,
                                      BewertungExtern    => Gesamtbewertung (KoordinatenExtern.EAchse, RasseSchleifenwert));
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end KartenfeldBewerten;
   
   
   
   procedure BewertungSelbst
     (KoordinatenFeldExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KoordinatenUmgebungExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Enum;
      TeilerExtern : in KartenDatentypen.UmgebungsbereichDrei)
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           SpielVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.KI_Spieler_Enum
           and
             (RasseExtern = EinheitenKonstanten.LeerRasse
              or
                RasseExtern = RasseSchleifenwert)
         then
            Bewertung (KoordinatenFeldExtern.EAchse) := Gesamtbewertung (KoordinatenFeldExtern.EAchse, RasseSchleifenwert)
              + KartenAllgemein.GrundBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                RasseExtern       => RasseSchleifenwert)
              / KartenDatentypen.Einzelbewertung (TeilerExtern);

            case
              LeseKarten.Fluss (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartengrundDatentypen.Leer_Fluss_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + KartenAllgemein.FlussBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                                                                                         RasseExtern       => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;
            
            case
              LeseKarten.Weg (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + KartenAllgemein.WegBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                                                                                       RasseExtern       => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;

            case
              LeseKarten.Verbesserung (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartenVerbesserungDatentypen.Leer_Verbesserung_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + KartenAllgemein.VerbesserungBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                                                                                                RasseExtern       => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;
      
            case
              LeseKarten.Ressource (KoordinatenExtern => KoordinatenUmgebungExtern)
            is
               when KartengrundDatentypen.Leer_Ressource_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + KartenAllgemein.RessourceBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                                                                                             RasseExtern       => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;
            
            Gesamtbewertung (KoordinatenFeldExtern.EAchse, RasseSchleifenwert) := Bewertung (KoordinatenFeldExtern.EAchse);
                        
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end BewertungSelbst;

end FelderwerteFestlegen;
