with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with ZahlenDatentypen;
with SpeziesDatentypen;
with SpielDatentypen;
with SpielRecords;

private with Grenzpruefungen;

package SchreibeAllgemeines is
   pragma Elaborate_Body;
   
   procedure Gewonnen;
   pragma Inline (Gewonnen);
   
   procedure Weiterspielen
     (WeiterspielenExtern : in Boolean);
   pragma Inline (Weiterspielen);
   
   procedure SpeziesAmzugNachLaden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum);
   pragma Inline (SpeziesAmzugNachLaden);
   
   procedure Schwierigkeitsgrad
     (SchwierigkeitsgradExtern : in SpielDatentypen.Schwierigkeitsgrad_Enum);
   pragma Inline (Schwierigkeitsgrad);
   
   procedure Rundenanzahl;
   pragma Inline (Rundenanzahl);
   
   procedure Rundengrenze
     (RundengrenzeExtern : in ZahlenDatentypen.EigenesNatural);
   pragma Inline (Rundengrenze);
   
   procedure Ironman
     (NameExtern : in Unbounded_Wide_Wide_String);
   pragma Inline (Ironman);
   
   procedure PlanetVernichtet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum);
   pragma Inline (PlanetVernichtet);
   
   procedure Zusammenbruchszeit
     (ZeitExtern : in ZahlenDatentypen.EigenerInteger;
      RechnenSetzenExtern : in Boolean);
   
   procedure AnzahlEingesetzterPZB;
   pragma Inline (AnzahlEingesetzterPZB);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure GanzerEintrag
     (EintragExtern : in SpielRecords.AllgemeinesRecord);
   pragma Inline (GanzerEintrag);
   
private
      
   function EigeneZahlPrüfen is new Grenzpruefungen.Standardprüfung (GanzeZahl => ZahlenDatentypen.EigenerInteger);

end SchreibeAllgemeines;
