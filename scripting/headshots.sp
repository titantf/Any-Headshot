#include <sdkhooks>

bool
	g_bHeadshot[MAXPLAYERS+1] = false;
	
public Plugin myinfo =
{
	name		=	"Titan.TF - Headshots",
	author		=	"myst",
	version		=	"1.0",
	url			=	"https://titan.tf"
}

public void OnPluginEnd()
{
	for (int iClient = 1; iClient <= MaxClients; iClient++)
	{
		if (IsClientInGame(iClient))
			g_bHeadshot[iClient] = false;
	}
}

public void OnClientPutInServer(int iClient) {
    SDKHook(iClient, SDKHook_TraceAttack, TraceAttack);
}

public void OnClientDisconnect(int iClient) {
	g_bHeadshot[iClient] = false;
}

public Action TraceAttack(int iVictim, int &iAttacker, int &iInflictor, float &flDamage, int &iDamageType, int &iAmmoType, int iHitBox, int iHitgroup)
{
    if (iHitgroup == 1)
	{
        iDamageType |= DMG_CRIT;
        return Plugin_Changed;
    }

    return Plugin_Continue;
}