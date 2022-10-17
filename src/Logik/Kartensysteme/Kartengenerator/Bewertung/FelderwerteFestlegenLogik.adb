pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with KartenKonstanten;
with EinheitenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;
with LeseKartenDatenbanken;
with LeseVerbesserungenDatenbank;

with KartenkoordinatenberechnungssystemLogik;
with KartenAllgemeinesLogik;

package body FelderwerteFestlegenLogik is
   
   procedure EinzelnesKartenfeldBewerten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
            
      YAchseÄnderungSchleife:
      for YAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseÄnderungSchleife:
         for XAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
                  
            KartenWertEins (KoordinatenExtern.EAchse) := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                     ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                                            YAchseÄnderungSchleifenwert,
                                                                                                                                                            XAchseÄnderungSchleifenwert),
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
            
            KartenWertZwei (KoordinatenExtern.EAchse) := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                                     ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung,
                                                                                                                                                            BewertungYÄnderungSchleifenwert,
                                                                                                                                                            BewertungXÄnderungSchleifenwert),
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
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.KI_Spieler_Enum
           and
             (RasseExtern = EinheitenKonstanten.LeerRasse
              or
                RasseExtern = RasseSchleifenwert)
         then
            SchreibeWeltkarte.Bewertung (KoordinatenExtern  => KoordinatenExtern,
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
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung = RassenDatentypen.KI_Spieler_Enum
           and
             (RasseExtern = EinheitenKonstanten.LeerRasse
              or
                RasseExtern = RasseSchleifenwert)
         then
            Bewertung (KoordinatenFeldExtern.EAchse) := Gesamtbewertung (KoordinatenFeldExtern.EAchse, RasseSchleifenwert) + KartenAllgemeinesLogik.GrundBewertung (KoordinatenExtern => KoordinatenUmgebungExtern,
                                                                                                                                                                    RasseExtern       => RasseSchleifenwert)
              / KartenDatentypen.Einzelbewertung (TeilerExtern);

            Fluss (KoordinatenFeldExtern.EAchse) := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenUmgebungExtern);
            
            case
              Fluss (KoordinatenFeldExtern.EAchse)
            is
               when KartengrundDatentypen.Leer_Fluss_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + LeseKartenDatenbanken.BewertungFluss (FlussExtern => Fluss (KoordinatenFeldExtern.EAchse),
                                                                                                                                               RasseExtern => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;
            
            Weg (KoordinatenFeldExtern.EAchse) := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenUmgebungExtern);
            
            case
              Weg (KoordinatenFeldExtern.EAchse)
            is
               when KartenverbesserungDatentypen.Leer_Weg_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + LeseVerbesserungenDatenbank.BewertungWeg (WegExtern   => Weg (KoordinatenFeldExtern.EAchse),
                                                                                                                                                   RasseExtern => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;
            
            Verbesserung (KoordinatenFeldExtern.EAchse) := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenUmgebungExtern);
            
            case
              Verbesserung (KoordinatenFeldExtern.EAchse)
            is
               when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + LeseVerbesserungenDatenbank.BewertungVerbesserung (VerbesserungExtern => Verbesserung (KoordinatenFeldExtern.EAchse),
                                                                                                                                                            RasseExtern        => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;
            
            Ressource (KoordinatenFeldExtern.EAchse) := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenUmgebungExtern);
      
            case
              Ressource (KoordinatenFeldExtern.EAchse)
            is
               when KartengrundDatentypen.Leer_Ressource_Enum =>
                  null;
            
               when others =>
                  Bewertung (KoordinatenFeldExtern.EAchse) := Bewertung (KoordinatenFeldExtern.EAchse) + LeseKartenDatenbanken.BewertungRessource (RessourceExtern => Ressource (KoordinatenFeldExtern.EAchse),
                                                                                                                                                   RasseExtern     => RasseSchleifenwert)
                    / KartenDatentypen.Einzelbewertung (TeilerExtern);
            end case;
            
            Gesamtbewertung (KoordinatenFeldExtern.EAchse, RasseSchleifenwert) := Bewertung (KoordinatenFeldExtern.EAchse);
                        
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
   end BewertungSelbst;

end FelderwerteFestlegenLogik;
