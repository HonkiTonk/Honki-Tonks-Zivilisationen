with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ZahlenDatentypen;
with RassenDatentypen;
with SpielDatentypen;

package SchreibeAllgemeines is
   pragma Elaborate_Body;
   
   procedure Gewonnen
     (GewonnenExtern : in Boolean);
   
   procedure Weiterspielen
     (WeiterspielenExtern : in Boolean);
   
   procedure RasseAmzugNachLaden
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
   procedure Schwierigkeitsgrad
     (SchwierigkeitsgradExtern : in SpielDatentypen.Schwierigkeitsgrad_Enum);
   
   procedure Rundenanzahl
     (RundenanzahlExtern : in ZahlenDatentypen.EigenesPositive);
   
   procedure Rundengrenze
     (RundengrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Ironman
     (NameExtern : in Unbounded_Wide_Wide_String);
   
   procedure PlanetVernichtet
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
   procedure Zusammenbruchszeit
     (ZusammenbruchszeitExtern : in ZahlenDatentypen.EigenerInteger);
   
   procedure AnzahlEingesetzterPZB
     (AnzahlExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Standardeinstellungen;

end SchreibeAllgemeines;
