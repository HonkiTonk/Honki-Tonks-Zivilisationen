with KartenRecordKonstanten;

with KIVariablen;

package body SchreibeKIVariablen is

   procedure Kriegszustand
     (ZustandExtern : in Boolean)
   is begin
      
      KIVariablen.Kriegszustand := ZustandExtern;
      
   end Kriegszustand;
   
   
   
   procedure Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      AbschnittExtern : in EinheitenDatentypen.Bewegungsplan;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      KIVariablen.Stadtverbindung (SpeziesExtern, AbschnittExtern) := KoordinatenExtern;
      
   end Stadtverbindung;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      KIVariablen.Kriegszustand := False;
      
      KIVariablen.Stadtverbindung := (others => (others => KartenRecordKonstanten.LeerKoordinate));
      
   end Standardeinstellungen;

end SchreibeKIVariablen;
