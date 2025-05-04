with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with GanzzahltestsHTSEB;

with ZahlenDatentypen;
with SpeziesDatentypen;
with SpielDatentypen;
with SpielRecords;

package SchreibeAllgemeines is
   pragma Elaborate_Body;
   
   procedure Gewonnen;
   pragma Inline (Gewonnen);
   
   procedure Weiterspielen
     (WeiterspielenExtern : in Boolean);
   pragma Inline (Weiterspielen);
   
   procedure SpezieszugNachLaden
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum);
   pragma Inline (SpezieszugNachLaden);
   
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
   
   procedure EingesetztePZB;
   pragma Inline (EingesetztePZB);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
   procedure GanzerEintrag
     (EintragExtern : in SpielRecords.AllgemeinesRecord);
   pragma Inline (GanzerEintrag);
   
private
      
   function EigeneZahlPrüfen is new GanzzahltestsHTSEB.Strichrechnung (GanzeZahl => ZahlenDatentypen.EigenerInteger);

end SchreibeAllgemeines;
