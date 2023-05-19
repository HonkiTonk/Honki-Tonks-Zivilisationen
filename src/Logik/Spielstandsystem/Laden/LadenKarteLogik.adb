with KartenKonstanten;

with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;

with LadezeitenLogik;
with Fehlermeldungssystem;
with FehlermeldungssystemZusatzinformationen;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenKarteLogik is
   
   function KarteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      case
        LadenPrüfenExtern
      is
         when True =>
            KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                                Karteneinstellungen);
            
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
            
         when False =>
            KartenRecords.PermanenteKartenparameterRecord'Read (Stream (File => DateiLadenExtern),
                                                                Karteneinstellungen);
      end case;
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. Karteneinstellungen.Kartengröße.XAchse loop
               
               if
                 False = ImmerVorhandenEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                                 KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                 LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
               
               elsif
                 False = ZusatzgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                              KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                              LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = FeldeffekteEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                              KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                              LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = FlussEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                        KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                        LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = RessourceEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                            KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                            LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = WegEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                      KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                      LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = VerbesserungEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                               KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                               LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                     
               elsif
                 False = EinheitEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                          KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                          LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               elsif
                 False = StadtEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                        KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                        LadenPrüfenExtern => LadenPrüfenExtern)
               then
                  return False;
                  
               else
                  null;
               end if;
                                             
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EAchseSchleife;
            
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end KarteLaden;
   
   
   
   function ImmerVorhandenEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            KartenRecords.SichtbarkeitArray'Read (Stream (File => DateiLadenExtern),
                                                  ImmerVorhanden.Sichtbarkeit);
            ImmerVorhanden.Basisgrund := KartengrundDatentypen.Wolken_Enum;
            
         when KartenKonstanten.WeltraumKonstante =>
            KartenRecords.SichtbarkeitArray'Read (Stream (File => DateiLadenExtern),
                                                  ImmerVorhanden.Sichtbarkeit);
            ImmerVorhanden.Basisgrund := KartengrundDatentypen.Weltraum_Enum;
            
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartenRecords.ImmerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                     ImmerVorhanden);
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "LadenKarteLogik.ImmerVorhandenEinlesen - Ungültige Ebene " & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => ImmerVorhanden.Basisgrund);
            SchreibeWeltkarte.GesamteSichtbarkeit (KoordinatenExtern  => KoordinatenExtern,
                                                   SichtbarkeitExtern => ImmerVorhanden.Sichtbarkeit);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end ImmerVorhandenEinlesen;
   
   
   
   function ZusatzgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.UnterflächeKonstante | KartenKonstanten.OberflächeKonstante =>
            Boolean'Read (Stream (File => DateiLadenExtern),
                          Vorhanden);
            
         when others =>
            return True;
      end case;
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                   Zusatzgrund);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => Zusatzgrund);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end ZusatzgrundEinlesen;
   
   
   
   function FeldeffekteEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
            
      Boolean'Read (Stream (File => DateiLadenExtern),
                    Vorhanden);
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            KartenRecords.FeldeffektArray'Read (Stream (File => DateiLadenExtern),
                                                Feldeffekte);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => KoordinatenExtern,
                                               FeldeffekteExtern => Feldeffekte);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end FeldeffekteEinlesen;
   
   
   
   function FlussEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            Boolean'Read (Stream (File => DateiLadenExtern),
                          Vorhanden);
            
         when others =>
            return True;
      end case;
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            KartenextraDatentypen.Fluss_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                             Fluss);
      end case;
               
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => Fluss);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
         
   end FlussEinlesen;
   
   
   
   function RessourceEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            Boolean'Read (Stream (File => DateiLadenExtern),
                          Vorhanden);
            
         when others =>
            return True;
      end case;
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Ressource);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern,
                                         RessourceExtern   => Ressource);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end RessourceEinlesen;
   
   
   
   function WegEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            Boolean'Read (Stream (File => DateiLadenExtern),
                          Vorhanden);
            
         when others =>
            return True;
      end case;
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Weg);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => Weg);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end WegEinlesen;
   
   
   
   function VerbesserungEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      Boolean'Read (Stream (File => DateiLadenExtern),
                    Vorhanden);
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                           Verbesserung);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                            VerbesserungExtern => Verbesserung);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end VerbesserungEinlesen;
   
   
   
   function EinheitEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      Boolean'Read (Stream (File => DateiLadenExtern),
                    Vorhanden);
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            EinheitenRecords.SpeziesEinheitnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                                       Einheit);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.EinheitSchreiben (KoordinatenExtern          => KoordinatenExtern,
                                                EinheitSpeziesNummerExtern => (Einheit.Spezies, Einheit.Nummer),
                                                EinheitentauschExtern      => True);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end EinheitEinlesen;
   
   
   
   function StadtEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      Boolean'Read (Stream (File => DateiLadenExtern),
                    Vorhanden);
      
      case
        Vorhanden
      is
         when False =>
            return True;
            
         when True =>
            StadtRecords.SpeziesStadtnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                                 Stadt);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KoordinatenExtern,
                                             BelegterGrundExtern => (Stadt.Spezies, Stadt.Nummer));
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         return False;
      
   end StadtEinlesen;

end LadenKarteLogik;
