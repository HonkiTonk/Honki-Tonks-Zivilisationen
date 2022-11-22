with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ZahlenDatentypen;
with RassenDatentypen;
with SpielDatentypen;

private with Grenzpruefungen;

package SchreibeAllgemeines is
   pragma Elaborate_Body;
   
   procedure Gewonnen;
   
   procedure Weiterspielen
     (WeiterspielenExtern : in Boolean);
   
   procedure RasseAmzugNachLaden
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
   procedure Schwierigkeitsgrad
     (SchwierigkeitsgradExtern : in SpielDatentypen.Schwierigkeitsgrad_Enum);
   
   procedure Rundenanzahl;
   
   procedure Rundengrenze
     (RundengrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   
   procedure Ironman
     (NameExtern : in Unbounded_Wide_Wide_String);
   
   procedure PlanetVernichtet
     (RasseExtern : in RassenDatentypen.Rassen_Enum);
   
   procedure Zusammenbruchszeit
     (ZeitExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean);
   
   procedure AnzahlEingesetzterPZB;
   
   procedure Standardeinstellungen;
   
private
      
   function EigeneZahlPrüfen is new Grenzpruefungen.Standardprüfung (GanzeZahl => ZahlenDatentypen.EigenerInteger);

end SchreibeAllgemeines;
