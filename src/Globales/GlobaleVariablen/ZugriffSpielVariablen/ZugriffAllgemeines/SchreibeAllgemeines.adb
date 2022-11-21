with SpielVariablen;
with WichtigesRecordKonstanten;

package body SchreibeAllgemeines is
   
   procedure Gewonnen
     (GewonnenExtern : in Boolean)
   is begin
      
      SpielVariablen.Allgemeines.Gewonnen := GewonnenExtern;
      
   end Gewonnen;
   
   
   
   procedure Weiterspielen
     (WeiterspielenExtern : in Boolean)
   is begin
      
      SpielVariablen.Allgemeines.Weiterspielen := WeiterspielenExtern;
      
   end Weiterspielen;
   
   
   
   procedure RasseAmzugNachLaden
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      SpielVariablen.Allgemeines.RasseAmZugNachLaden := RasseExtern;
      
   end RasseAmzugNachLaden;
   
      
   
   procedure Schwierigkeitsgrad
     (SchwierigkeitsgradExtern : in SpielDatentypen.Schwierigkeitsgrad_Enum)
   is begin
      
      SpielVariablen.Allgemeines.Schwierigkeitsgrad := SchwierigkeitsgradExtern;
      
   end Schwierigkeitsgrad;
   
      
   
   procedure Rundenanzahl
     (RundenanzahlExtern : in ZahlenDatentypen.EigenesPositive)
   is begin
      
      SpielVariablen.Allgemeines.Rundenanzahl := RundenanzahlExtern;
      
   end Rundenanzahl;
   
   
      
   procedure Rundengrenze
     (RundengrenzeExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Allgemeines.Rundengrenze := RundengrenzeExtern;
      
   end Rundengrenze;
   
   
      
   procedure Ironman
     (NameExtern : in Unbounded_Wide_Wide_String)
   is begin
      
      SpielVariablen.Allgemeines.IronmanName := NameExtern;
      
   end Ironman;
   
   
   
      procedure PlanetVernichtet
     (RasseExtern : in RassenDatentypen.Rassen_Enum)
   is begin
      
      SpielVariablen.Allgemeines.PlanetVernichtet := RasseExtern;
      
   end PlanetVernichtet;
   
      
   
   procedure Zusammenbruchszeit
     (ZusammenbruchszeitExtern : in ZahlenDatentypen.EigenerInteger)
   is begin
      
      SpielVariablen.Allgemeines.Zusammenbruchszeit := ZusammenbruchszeitExtern;
      
   end Zusammenbruchszeit;
   
   
   
   procedure AnzahlEingesetzterPZB
     (AnzahlExtern : in ZahlenDatentypen.EigenesNatural)
   is begin
      
      SpielVariablen.Allgemeines.AnzahlEingesetzterPZB := AnzahlExtern;
      
   end AnzahlEingesetzterPZB;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Allgemeines := WichtigesRecordKonstanten.LeerAllgemeines;
      
   end Standardeinstellungen;

end SchreibeAllgemeines;
