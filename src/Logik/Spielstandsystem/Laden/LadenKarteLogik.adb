with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeWeltkarte;
with SchreibeWeltkarteneinstellungen;
with LadezeitenLogik;

with Diagnoseinformationen;

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
                              
               -- ImmerVorhandenSchreiben (DateiLadenExtern  => DateiLadenExtern,
               --                          KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
               --                          LadenPrüfenExtern => LadenPrüfenExtern);
               
               ZusatzgrundEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                    KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                    LadenPrüfenExtern => LadenPrüfenExtern);
               
               FeldeffekteEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                    KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                    LadenPrüfenExtern => LadenPrüfenExtern);
               
               FlussEinlesen (DateiLadenExtern  => DateiLadenExtern,
                              KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                              LadenPrüfenExtern => LadenPrüfenExtern);
                              
               RessourceEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                  KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                  LadenPrüfenExtern => LadenPrüfenExtern);
               
               WegEinlesen (DateiLadenExtern  => DateiLadenExtern,
                            KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                            LadenPrüfenExtern => LadenPrüfenExtern);
               
               VerbesserungEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                     KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                     LadenPrüfenExtern => LadenPrüfenExtern);
                              
               EinheitEinlesen (DateiLadenExtern  => DateiLadenExtern,
                                KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                LadenPrüfenExtern => LadenPrüfenExtern);
                              
               StadtEinlesen (DateiLadenExtern  => DateiLadenExtern,
                              KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                              LadenPrüfenExtern => LadenPrüfenExtern);
                                             
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EAchseSchleife;
            
      return True;
      
      -- exception
      --    when Constraint_Error | End_Error =>
      --       return False;
      
   end KarteLaden;
   
   
   
   procedure ImmerVorhandenSchreiben
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      KartenRecords.ImmerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                               ImmerVorhanden);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.ImmerVorhanden (KoordinatenExtern    => KoordinatenExtern,
                                              ImmerVorhandenExtern => ImmerVorhanden);
            
         when False =>
            null;
      end case;
            
   end ImmerVorhandenSchreiben;
   
   
   
   procedure ZusatzgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      Streamposition := Index (File => DateiLadenExtern);
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.WeltraumKonstante =>
            raise NichtVorhanden;
            
         when KartenKonstanten.HimmelKonstante =>
            raise NichtVorhanden;
            
         when KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum'Read (Stream (File => DateiLadenExtern),
                                                                     ZusatzgrundOberfläche);
            Zusatzgrund := ZusatzgrundOberfläche;
            
         when KartenKonstanten.UnterflächeKonstante =>
            KartengrundDatentypen.Zusatzgrund_Unterfläche_Enum'Read (Stream (File => DateiLadenExtern),
                                                                      ZusatzgrundUnterflaeche);
            Zusatzgrund := ZusatzgrundUnterflaeche;
            
         when KartenKonstanten.PlaneteninneresKonstante =>
            raise NichtVorhanden;
            
         when others =>
            raise NichtVorhanden;
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
      
      Diagnoseinformationen.Text (TextExtern => Zusatzgrund'Wide_Wide_Image);
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error | NichtVorhanden =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
      
   end ZusatzgrundEinlesen;
   
   
   
   procedure FeldeffekteEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is
      use type KartenRecords.FeldeffektArray;
   begin
      
      Streamposition := Index (File => DateiLadenExtern);
      KartenRecords.FeldeffektArray'Read (Stream (File => DateiLadenExtern),
                                          Feldeffekte);
      
      if
        Feldeffekte = KartenRecordKonstanten.LeerEffekte
      then
         raise Constraint_Error;
         
      else
         null;
      end if;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => KoordinatenExtern,
                                               FeldeffekteExtern => Feldeffekte);
            
         when False =>
            null;
      end case;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
      
   end FeldeffekteEinlesen;
   
   
   
   procedure FlussEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      Streamposition := Index (File => DateiLadenExtern);
      KartenextraDatentypen.Fluss_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                       Fluss);
               
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                                     FlussExtern       => Fluss);
            
         when False =>
            null;
      end case;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
         
   end FlussEinlesen;
   
   
   
   procedure RessourceEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      Streamposition := Index (File => DateiLadenExtern);
      KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                            Ressource);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern,
                                         RessourceExtern   => Ressource);
            
         when False =>
            null;
      end case;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
      
   end RessourceEinlesen;
   
   
   
   procedure WegEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      Streamposition := Index (File => DateiLadenExtern);
      KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                            Weg);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                   WegExtern         => Weg);
            
         when False =>
            null;
      end case;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
      
   end WegEinlesen;
   
   
   
   procedure VerbesserungEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      Streamposition := Index (File => DateiLadenExtern);
      KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                     Verbesserung);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                            VerbesserungExtern => Verbesserung);
            
         when False =>
            null;
      end case;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
      
   end VerbesserungEinlesen;
   
   
   
   procedure EinheitEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      Streamposition := Index (File => DateiLadenExtern);
      EinheitenRecords.SpeziesEinheitnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                                 Einheit);
      
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
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
      
   end EinheitEinlesen;
   
   
   
   procedure StadtEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
   is begin
      
      Streamposition := Index (File => DateiLadenExtern);
      StadtRecords.SpeziesStadtnummerVorhandenRecord'Read (Stream (File => DateiLadenExtern),
                                                           Stadt);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KoordinatenExtern,
                                             BelegterGrundExtern => (Stadt.Spezies, Stadt.Nummer));
            
         when False =>
            null;
      end case;
      
   exception
      when Constraint_Error | End_Error | Status_Error | Mode_Error | Name_Error | Use_Error | Device_Error | Data_Error =>
         Set_Index (File => DateiLadenExtern,
                    To   => Streamposition);
      
   end StadtEinlesen;

end LadenKarteLogik;
