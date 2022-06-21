pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;
with ForschungenDatentypen;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;

package body KIEinheitAllgemeinePruefungen is
   
   function BlockiertDurchWasser
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      Wasserfelder := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            Wasserumgebung := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                     ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                     LogikGrafikExtern => True);
            
            if
              Wasserumgebung.XAchse = KartenKonstanten.LeerXAchse
            then
               Wasserfelder := Wasserfelder + 1;
               
            elsif
              LeseKarten.BasisGrund (KoordinatenExtern => Wasserumgebung) = KartengrundDatentypen.Wasser_Enum
            then
               Wasserfelder := Wasserfelder + 1;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      case
        Wasserfelder
      is
         when 8 =>
            null;
            
         when others =>
            return False;
      end case;
      
      ------------------------------------- Hier später noch brauchbare Prüfungen auf vorhandene Technologie und Wassertransporter einbauen.
      ForschungenSchleife:
      for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
         null;
         
      end loop ForschungenSchleife;
      
      return True;
      
   end BlockiertDurchWasser;
   
end KIEinheitAllgemeinePruefungen;
