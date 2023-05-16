with KartenKonstanten;
with KartenRecordKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;

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
   is
      use type KartenRecords.FeldeffektArray;
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
      use type StadtRecords.SpeziesStadtnummerRecord;
   begin
      
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
            
            SchreibeWeltkarteneinstellungen.GesamteEinstellungen (EinstellungenExtern => Karteneinstellungen);
      end case;

      EAchseSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. Karteneinstellungen.Kartengröße.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. Karteneinstellungen.Kartengröße.XAchse loop

               Diagnoseinformationen.Zahl (ZahlExtern => 1);
               WeltkarteRecords.ImmerVorhanden'Read (Stream (File => DateiLadenExtern),
                                                     ImmerVorhanden);
               
               SchreibeWeltkarte.ImmerVorhanden (ImmerVorhandenExtern => ImmerVorhanden,
                                                 KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               Streamposition := Index (File => DateiLadenExtern);
               Diagnoseinformationen.Zahl (ZahlExtern => Integer (Index (File => DateiLadenExtern)));
               Zusatzgrund := ZusatzgrundEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               case
                 Zusatzgrund
               is
                  when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
                     Diagnoseinformationen.Zahl (ZahlExtern => Integer (Index (File => DateiLadenExtern)));
                     Set_Index (File => DateiLadenExtern,
                                To   => Streamposition);
                     Diagnoseinformationen.Zahl (ZahlExtern => Integer (Index (File => DateiLadenExtern)));
                     
                  when others =>
                     SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                    GrundExtern       => Zusatzgrund);
               end case;
               
               Streamposition := Index (File => DateiLadenExtern);
               Feldeffekte := FeldeffekteEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               if
                 Feldeffekte = KartenRecordKonstanten.LeerEffekte
               then
                  Set_Index (File => DateiLadenExtern,
                             To   => Streamposition);
                  
               else
                  SchreibeWeltkarte.AlleFeldeffekte (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                     FeldeffekteExtern => Feldeffekte);
               end if;
               
               Streamposition := Index (File => DateiLadenExtern);
               Fluss := FlussEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               case
                 Fluss
               is
                  when KartenextraDatentypen.Leer_Fluss_Enum =>
                     Set_Index (File => DateiLadenExtern,
                                To   => Streamposition);
                     
                  when others =>
                     SchreibeWeltkarte.Fluss (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                              FlussExtern       => Fluss);
               end case;
               
               Streamposition := Index (File => DateiLadenExtern);
               Ressource := RessourceEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               case
                 Ressource
               is
                  when KartenextraDatentypen.Leer_Ressource_Enum =>
                     Set_Index (File => DateiLadenExtern,
                                To   => Streamposition);
                     
                  when others =>
                     SchreibeWeltkarte.Ressource (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                  RessourceExtern   => Ressource);
               end case;
               
               Streamposition := Index (File => DateiLadenExtern);
               Weg := WegEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               case
                 Weg
               is
                  when KartenverbesserungDatentypen.Leer_Weg_Enum =>
                     Set_Index (File => DateiLadenExtern,
                                To   => Streamposition);
                     
                  when others =>
                     SchreibeWeltkarte.Weg (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                            WegExtern         => Weg);
               end case;
               
               Streamposition := Index (File => DateiLadenExtern);
               Verbesserung := VerbesserungEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               case
                 Verbesserung
               is
                  when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
                     Set_Index (File => DateiLadenExtern,
                                To   => Streamposition);
                     
                  when others =>
                     SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                     VerbesserungExtern => Verbesserung);
               end case;
               
               Streamposition := Index (File => DateiLadenExtern);
               Einheit := EinheitEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               if
                 Einheit = EinheitenKonstanten.LeerEinheit
               then
                  Set_Index (File => DateiLadenExtern,
                             To   => Streamposition);
                  
               else
                  SchreibeWeltkarte.EinheitSchreiben (KoordinatenExtern          => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                      EinheitSpeziesNummerExtern => Einheit,
                                                      EinheitentauschExtern      => True);
               end if;
               
               Streamposition := Index (File => DateiLadenExtern);
               Stadt := StadtEinlesen (DateiLadenExtern => DateiLadenExtern);
               
               if
                 Stadt = StadtKonstanten.LeerStadt
               then
                  Set_Index (File => DateiLadenExtern,
                             To   => Streamposition);
                  
               else
                  SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                   BelegterGrundExtern => Stadt);
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
         
      end loop EAchseSchleife;
      
      return True;
      
  -- exception
  --    when Constraint_Error | End_Error =>
   --      return False;
      
   end KarteLaden;
   
   
   
   function ZusatzgrundEinlesen
     (DateiLadenExtern : in File_Type)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      KartengrundDatentypen.Zusatzgrund_Enum'Read (Stream (File => DateiLadenExtern),
                                                   Zusatzgrund);
      
      return Zusatzgrund;
      
   exception
      when Constraint_Error | End_Error =>
         return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
      
   end ZusatzgrundEinlesen;
   
   
   
   function FeldeffekteEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenRecords.FeldeffektArray
   is begin
      
      KartenRecords.FeldeffektArray'Read (Stream (File => DateiLadenExtern),
                                          Feldeffekte);
      
      return Feldeffekte;
      
   exception
      when Constraint_Error | End_Error =>
         return KartenRecordKonstanten.LeerEffekte;
      
   end FeldeffekteEinlesen;
   
   
   
   function FlussEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenextraDatentypen.Fluss_Enum
   is begin
      
      KartenextraDatentypen.Fluss_Enum'Read (Stream (File => DateiLadenExtern),
                                             Fluss);
      
      return Fluss;
      
   exception
      when Constraint_Error | End_Error =>
         return KartenextraDatentypen.Leer_Fluss_Enum;
         
   end FlussEinlesen;
   
   
   
   function RessourceEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenextraDatentypen.Ressourcen_Enum
   is begin
      
      KartenextraDatentypen.Ressourcen_Enum'Read (Stream (File => DateiLadenExtern),
                                                  Ressource);
      
      return Ressource;
      
   exception
      when Constraint_Error | End_Error =>
         return KartenextraDatentypen.Leer_Ressource_Enum;
      
   end RessourceEinlesen;
   
   
   
   function WegEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenverbesserungDatentypen.Weg_Enum
   is begin
      
      KartenverbesserungDatentypen.Weg_Enum'Read (Stream (File => DateiLadenExtern),
                                                  Weg);
      
      return Weg;
      
   exception
      when Constraint_Error | End_Error =>
         return KartenverbesserungDatentypen.Leer_Weg_Enum;
      
   end WegEinlesen;
   
   
   
   function VerbesserungEinlesen
     (DateiLadenExtern : in File_Type)
      return KartenverbesserungDatentypen.Verbesserung_Enum
   is begin
      
      KartenverbesserungDatentypen.Verbesserung_Enum'Read (Stream (File => DateiLadenExtern),
                                                           Verbesserung);
      
      return Verbesserung;
      
   exception
      when Constraint_Error | End_Error =>
         return KartenverbesserungDatentypen.Leer_Verbesserung_Enum;
      
   end VerbesserungEinlesen;
   
   
   
   function EinheitEinlesen
     (DateiLadenExtern : in File_Type)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is begin
      
      EinheitenRecords.SpeziesEinheitnummerRecord'Read (Stream (File => DateiLadenExtern),
                                                        Einheit);
      
      return Einheit;
      
   exception
      when Constraint_Error | End_Error =>
         return EinheitenKonstanten.LeerEinheit;
      
   end EinheitEinlesen;
   
   
   
   function StadtEinlesen
     (DateiLadenExtern : in File_Type)
      return StadtRecords.SpeziesStadtnummerRecord
   is begin
      
      StadtRecords.SpeziesStadtnummerRecord'Read (Stream (File => DateiLadenExtern),
                                                  Stadt);
      
      return Stadt;
      
   exception
      when Constraint_Error | End_Error =>
         return StadtKonstanten.LeerStadt;
      
   end StadtEinlesen;

end LadenKarteLogik;
