with KartenRecordKonstanten;
with KartenartDatentypen;

with KartenkoordinateEAchseBerechnenLogik;
with KartenkoordinateYAchseBerechnenLogik;
with KartenkoordinateXAchseBerechnenLogik;
with KartenkoordinatenWerteLogik;

package body KartenkoordinatenberechnungssystemLogik is

   -- Zufallsübergänge einbauen? äöü
   function Kartenkoordinatenberechnungssystem
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      if
        KoordinatenExtern = KartenRecordKonstanten.LeerKoordinate
      then
         return KartenRecordKonstanten.LeerKoordinate;
         
      else
         null;
      end if;
      
      case
        ÄnderungExtern.EAchse
      is
         when KartenKonstanten.LeerEAchseÄnderung =>
            NeueKoordinate (TaskExtern).EAchse := KoordinatenExtern.EAchse;
            
         when others =>
            NeueKoordinate (TaskExtern).EAchse := KartenkoordinateEAchseBerechnenLogik.KartenkoordinateEAchseBerechnen (EAchseExtern         => KoordinatenExtern.EAchse,
                                                                                                                        ÄnderungEAchseExtern => ÄnderungExtern.EAchse,
                                                                                                                        TaskExtern    => TaskExtern);
            
            if
              NeueKoordinate (TaskExtern).EAchse = KartenKonstanten.LeerEAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.YAchseVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                               ÜbergangExtern => KartenartDatentypen.Karte_Y_Kein_Übergang_Enum);
      
      case
        ÄnderungExtern.YAchse
      is
         when KartenKonstanten.LeerYAchseÄnderung =>
            NeueKoordinate (TaskExtern).YAchse := KoordinatenExtern.YAchse;
            
         when others =>
            NeueKoordinate (TaskExtern).YAchse := KartenkoordinateYAchseBerechnenLogik.KartenkoordinateYAchseBerechnen (YAchseExtern         => KoordinatenExtern.YAchse,
                                                                                                                        ÄnderungYAchseExtern => ÄnderungExtern.YAchse,
                                                                                                                        TaskExtern    => TaskExtern);
      
            if
              NeueKoordinate (TaskExtern).YAchse = KartenKonstanten.LeerYAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
            
            else
               null;
            end if;
      end case;
      
      KartenkoordinatenWerteLogik.XAchseVerschiebungSchreiben (TaskExtern     => TaskExtern,
                                                               ÜbergangExtern => KartenartDatentypen.Karte_X_Kein_Übergang_Enum);
            
      case
        ÄnderungExtern.XAchse
      is
         when KartenKonstanten.LeerXAchseÄnderung =>
            NeueKoordinate (TaskExtern).XAchse := KoordinatenExtern.XAchse;
            
         when others =>
            NeueKoordinate (TaskExtern).XAchse := KartenkoordinateXAchseBerechnenLogik.KartenkoordinateXAchseBerechnen (XAchseExtern         => KoordinatenExtern.XAchse,
                                                                                                                        ÄnderungXAchseExtern => ÄnderungExtern.XAchse,
                                                                                                                        TaskExtern    => TaskExtern);
            
            if
              NeueKoordinate (TaskExtern).XAchse = KartenKonstanten.LeerXAchse
            then
               return KartenRecordKonstanten.LeerKoordinate;
                  
            else
               null;
            end if;
      end case;
      
      case
        KartenkoordinatenWerteLogik.YAchseVerschiebungLesen (TaskExtern => TaskExtern)
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum | KartenartDatentypen.Karte_Y_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            NeueKoordinate (TaskExtern).XAchse := KartenkoordinateXAchseBerechnenLogik.XAchseVerschieben (XAchseExtern => NeueKoordinate (TaskExtern).XAchse);
      end case;
      
      case
        KartenkoordinatenWerteLogik.XAchseVerschiebungLesen (TaskExtern => TaskExtern)
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum | KartenartDatentypen.Karte_X_Übergang_Enum =>
            null;
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            NeueKoordinate (TaskExtern).YAchse := KartenkoordinateYAchseBerechnenLogik.YAchseVerschieben (YAchseExtern => NeueKoordinate (TaskExtern).YAchse);
      end case;
      
      return NeueKoordinate (TaskExtern);
      
   end Kartenkoordinatenberechnungssystem;

end KartenkoordinatenberechnungssystemLogik;
